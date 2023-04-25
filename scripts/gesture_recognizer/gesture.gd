class_name Gesture
extends RefCounted

const SAMPLING_RESOLUTION = 64
const MAX_INT_COORDINATE = 1024
const LUT_SIZE = 64
const LUT_SCALE_FACTOR = int(MAX_INT_COORDINATE / float(LUT_SIZE))
const FLOAT_MAX_VALUE = 1.79769e308
const FLOAT_MIN_VALUE = -1.79769e308
const INT_MAX_VALUE = 9223372036854775807

var name: String = ""
var is_computing_lut := true


var _normalized_points: Array[Point]
var _raw_points: Array[Point]

# Type: Array[Array[int]]
var _lut: Array = []


# Could use _init but outside of structs like Vector the godot API
# doesn't use constructors. So I like to avoid using them when coding for the most part.
func initialize(points: Array[Point]):
	_raw_points = points
	
	for point in _raw_points:
		_normalized_points.append(point.duplicate())
	
	_raw_points.make_read_only()
	_normalized_points.make_read_only()
	_normalize()


func get_points() -> Array[Point]:
	return _normalized_points


func get_point_count() -> int:
	return _normalized_points.size()


func get_lut() -> Array:
	return _lut


func _normalize():
	_normalized_points = _resample(_raw_points, SAMPLING_RESOLUTION)
	_normalized_points = _scale(_normalized_points)
	_normalized_points = _translate_to(_normalized_points, _centroid(_normalized_points))

	if (is_computing_lut):
		_transform_points_to_ints()
		_construct_lut()


func _resample(points: Array[Point], sampling_resolution: int) -> Array[Point]:
	var new_points: Array[Point] = [points[0]]
	var interval_length := _path_length(_normalized_points) / (sampling_resolution - 1)
	var total_length := 0.0

	for i in range(1, points.size()):
		var current_point := points[i]
		var previous_point := points[i - 1]

		if current_point.stroke_id == previous_point.stroke_id:
			var segment_length = previous_point.position.distance_to(current_point.position)
			if total_length + segment_length >= interval_length:
				while total_length + segment_length >= interval_length:
					# Add Interpolated Point
					var t = min(maxf((interval_length - total_length) / segment_length, 0), 1.0) if segment_length > 0 else 0.5
					
					# Just a precaution. The original code had a NaN check but
					# im not sure why apart from the potential divide by 0.
					# Which would just result in a runtime error in godot at division.
					if is_nan(t):
						t = 0.5
					
					# Add Interpolated Point
					var new_point := Point.new()
					new_point.position = (1.0 - t) * (previous_point.position + current_point.position * t)
					new_point.stroke_id = current_point.stroke_id
					new_points.append(new_point)
					
					# Update Partial Length
					segment_length = total_length + segment_length - interval_length
					total_length = 0
					previous_point = new_points.back()
				total_length = segment_length
			else:
				total_length += segment_length
		
	if new_points.size() == sampling_resolution - 1:
		var new_point: Point = points.back().duplicate()
		new_points.append(new_point)
	
	return new_points


func _scale(points: Array[Point]):
	# I wish I understood the purpose of this
	var min_pos := Vector2(FLOAT_MAX_VALUE, FLOAT_MAX_VALUE)
	var max_pos := Vector2(FLOAT_MIN_VALUE, FLOAT_MIN_VALUE)
	for point in points:
		min_pos.x = minf(min_pos.x, point.position.x)
		min_pos.y = minf(min_pos.y, point.position.y)
		max_pos.x = maxf(max_pos.x, point.position.x)
		max_pos.y = maxf(max_pos.y, point.position.y)
	
	var new_points: Array[Point] = []
	var scale := maxf(max_pos.x - min_pos.x, max_pos.y - min_pos.y)
	
	for point in points:
		var new_point := point.duplicate()
		new_point.position = Vector2((point.position.x - min_pos.x), (point.position.y - min_pos.y)) / scale
		new_points.append(new_point)
	
	return new_points


func _translate_to(points: Array[Point], to: Point) -> Array[Point]:
	var new_points: Array[Point] = []
	
	for point in points:
		var new_point := point.duplicate()
		new_point.position = Vector2(point.position.x - to.position.x, point.position.y - to.position.y)
		new_points.append(new_point)
	
	return new_points
	
	
func _path_length(points: Array[Point]) -> float:
	var length := 0.0
	
	for i in range(1, points.size()):
		var current_point := points[i]
		var previous_point := points[i - 1]
		if current_point.stroke_id == previous_point.stroke_id:
			length += previous_point.position.distance_to(current_point.position)
	
	return length


func _centroid(points: Array[Point]) -> Point:
	var center := Vector2.ZERO
	
	for point in points:
		center += point.position
	
	var new_point := Point.new()
	new_point.position = center / points.size()

	return new_point


func _transform_points_to_ints() -> void:
	for point in _normalized_points:
		point.position_i = Vector2i(Vector2(point.position.x + 1.0, point.position.y + 1.0) / (2.0 * (MAX_INT_COORDINATE - 1)))


func _construct_lut() -> void:
	_lut.clear()

	for i in LUT_SIZE:
		var arr: Array[int] = []
		arr.resize(LUT_SIZE)
		_lut.append(arr)
	
	for i in LUT_SIZE:
		for j in LUT_SIZE:
			var min_dist := INT_MAX_VALUE
			var index_min = -1
			
			for t in _normalized_points.size():
				var mat_coord := _normalized_points[t].position_i / LUT_SCALE_FACTOR
				var dist = (mat_coord.y - i) * (mat_coord.y - i) + (mat_coord.x - j) * (mat_coord.x - j)
				
				if (dist < min_dist):
					min_dist = dist
					index_min = t

			_lut[i][j] = index_min
