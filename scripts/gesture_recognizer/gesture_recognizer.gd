class_name GestureRecognizer
extends RefCounted

const _FLOAT_MAX_VALUE = 1.79769e308

var templates: Array[Gesture]
var is_using_lower_bounding := true
var is_using_early_abandoning := true


func recognize(candidate: Gesture) -> Gesture:
	var min_dist = _FLOAT_MAX_VALUE
	var matched_template: Gesture = null
	
	for template in templates:
		var dist = _greedy_cloud_match(candidate, template, min_dist)
		if (dist < min_dist):
			min_dist = dist
			matched_template = template
	
	return matched_template


func _greedy_cloud_match(gesture1: Gesture, gesture2: Gesture, min_so_far: float) -> float:
	var point_count := gesture1.get_point_count()
	var eps = 0.5
	var step = floori(pow(point_count, 1.0 - eps))
	
	if is_using_lower_bounding:
		var lb1 := _compute_lower_bound(gesture1.get_points(), gesture2.get_points(), gesture2.get_lut(), step) 
		var lb2 := _compute_lower_bound(gesture2.get_points(), gesture1.get_points(), gesture1.get_lut(), step)
		var i := 0
		var index_lb := 0
		
		while i < point_count:
			if lb1[index_lb] < min_so_far:
				min_so_far = minf(min_so_far, _compute_cloud_distance(gesture1.get_points(), gesture2.get_points(), i, min_so_far))

			if lb2[index_lb] < min_so_far:
				min_so_far = minf(min_so_far, _compute_cloud_distance(gesture2.get_points(), gesture1.get_points(), i, min_so_far))
			
			i += step
			index_lb += 1 
	else:
		var i := 0
		
		while i < point_count:
			min_so_far = minf(min_so_far, _compute_cloud_distance(gesture1.get_points(), gesture2.get_points(), i, min_so_far))
			min_so_far = minf(min_so_far, _compute_cloud_distance(gesture2.get_points(), gesture1.get_points(), i, min_so_far))
			
			i += step
	
	return min_so_far


func _compute_lower_bound(points1: Array[Point], points2: Array[Point], lut: Array, step: int) -> Array[float]:
	var point_count := points1.size()
	var lower_bounds: Array[float] = [0]
	var sum_area_tables: Array[float] = []

	lower_bounds.resize((point_count / step) + 1)
	sum_area_tables.resize(point_count)
	
	for i in point_count:
		var current_point1 := points1[i]
		var current_point2 := points2[i]
		var index: int = lut[current_point1.position_i.y / Gesture.LUT_SCALE_FACTOR][current_point1.position_i.x / Gesture.LUT_SCALE_FACTOR]
		var dist := current_point1.position.distance_squared_to(current_point2.position)
		
		sum_area_tables[i] = dist if i == 0 else sum_area_tables[i - 1] + dist
		lower_bounds[0] += (point_count - i) * dist
	
	var i := step
	var index_lb := 1

	while i < point_count:
		lower_bounds[index_lb] = lower_bounds[0] + i * sum_area_tables[point_count - 1] - point_count * sum_area_tables[i - 1]

		i += step
		index_lb += 1

	return lower_bounds


func _compute_cloud_distance(points1: Array[Point], points2: Array[Point], start_index: int, min_so_far: float) -> float:
	var point_count := points1.size()
	var unmatched_indexes: Array[int] = []
	unmatched_indexes.resize(point_count)
	
	for i in point_count:
		unmatched_indexes[i] = i
	
	var sum := 0.0
	var i := start_index
	var weight := point_count
	var unmatched_index := 0
	
	while true:
		var index := -1
		var min_dist = _FLOAT_MAX_VALUE
		
		for j in range(unmatched_index, point_count):
			var p2_index := unmatched_indexes[j]
			var dist = points1[i].position.distance_squared_to(points2[p2_index].position)
			
			if dist < min_dist:
				min_dist = dist
				index = j
		
		unmatched_indexes[index] = unmatched_indexes[unmatched_index]
		sum += weight * min_dist
		weight -= 1
		
		if is_using_early_abandoning and sum >= min_so_far:
			return sum
		
		i = (i + 1) % point_count
		unmatched_index += 1
		
		if i != start_index:
			break
	
	return sum
