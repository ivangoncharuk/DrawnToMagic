@icon("res://assets/icon/glyph_recognizer_icon.png")
extends Node
class_name GlyphRecognizer

@export var templates : Array [GlyphTemplate] = []

## GLYPH RECOGNITION LOGIC

var spell_map = {
	"square": "☐",
	"line": "_",
}


@export var glyph_templates : Array[GlyphTemplate] = []

#func load_templates(file_path: String) -> Dictionary:
#	var file = FileAccess.open(file_path, FileAccess.READ)
#	if file == null:
#		return {}
#	var contents = file.get_as_text()
#	file.close()
#
#	var _templates = {}
#	for line in contents.split("\n"):
#		line = line.lstrip(" ").rstrip(" ")
#		if line == "":
#			continue
#		var template_parts = line.split(",")
#		var glyph_name = template_parts[0]
#		var glyph_points = []
#		for i in range(1, len(template_parts), 2):
#			var x = float(template_parts[i])
#			var y = float(template_parts[i + 1])
#			glyph_points.append(Vector2(x, y))
#		_templates[glyph_name] = glyph_points
#	return _templates



func recognize(points: PackedVector2Array) -> String:
	var best_match = ""
	var best_score = -1.0
	for template in templates:
		var score = compare_glyphs(points, template.data)
		if score > best_score:
			best_score = score
			best_match = template.name
	return best_match


## This function compares two glyphs represented as sequences of 2D 
## points by computing their similarity score using the Dynamic Time
## Warping (DTW) distance. 
func compare_glyphs(glyph1: PackedVector2Array, glyph2: PackedVector2Array) -> float:
	# Define the template gesture for the algorithm
	var template = PackedVector2Array([Vector2(0, 0), Vector2(0, 1), Vector2(1, 1), Vector2(1, 0)])

	var resampled1 = resample(glyph1, template.size())
	var resampled2 = resample(glyph2, template.size())

	# Calculate the indicative angle of the points

	var theta1 = indicative_angle(resampled1)
	var theta2 = indicative_angle(resampled2)
	resampled1 = rotate_by(resampled1, -theta1)
	resampled2 = rotate_by(resampled2, -theta2)

	var scale1 = scale_to_square(resampled1, template[1].distance_to(template[2]))
	var scale2 = scale_to_square(resampled2, template[1].distance_to(template[2]))


	var centroid1 = get_centroid(scale1)
	var centroid2 = get_centroid(scale2)
	
	var translate1 = translate_by(scale1, -centroid1)
	var translate2 = translate_by(scale2, -centroid2)

	var distance = dtw_distance(translate1, translate2)

	# Calculate the similarity score as the inverse of the DTW distance
	var score = 1.0 / (1.0 + distance)

	return score

func dtw_distance(glyph1: PackedVector2Array, glyph2: PackedVector2Array) -> float:
	var n = glyph1.size()
	var m = glyph2.size()

	var DTW = PackedFloat32Array()
	for i in range(m+1):
		DTW.append(float("inf"))
	DTW[0] = 0

	for i in range(1, n+1):
		var prev = DTW[0]
		DTW[0] = float("inf")
		for j in range(1, m+1):
			var current = DTW[j]
			var cost = (glyph1[i-1] - glyph2[j-1]).length_squared()
			DTW[j] = cost + min(DTW[j], DTW[j-1], prev)
			prev = current
	
	return DTW[m]

	# Resample both input gestures to the same number of points


## This uniformly resamples an input sequence of 2D points
## to a new length by adding interpolated points along the
## original path. 
func resample(points: PackedVector2Array, n: int) -> PackedVector2Array:
	var step = points.size() / (n - 1)
	var resampled = PackedVector2Array()
	if points.size() == 0:
		print_debug("ERROR: points.size() should be > 0, \npoints.size() = ", points.size())
		pass
	resampled.append(points[0])
	var i = 1
	var t = 0.0
	while i < points.size() and resampled.size() < n:
		var v = points[i] - points[i-1]
		var d = v.length()
		if t + d >= step:
			var x = points[i-1] + ((step - t) / d) * v
			resampled.append(x)
			t = 0.0
		else:
			t += d
		i += 1
	if resampled.size() < n:
		resampled.append(points[points.size() - 1])
	return resampled


## Calculates the centroid of a sequence of 2D points
func get_centroid(points: PackedVector2Array) -> Vector2:
	var acc = Vector2.ZERO
	for p in points:
		acc += p
	# Divide the accumulated vector by the number of points to obtain the centroid vector
	return acc / points.size()


## This function calculates the indicative angle (in radians) of a sequence
## of 2D points relative to their centroid. 
func indicative_angle(points: PackedVector2Array) -> float:
	var centroid = get_centroid(points)
	var theta = atan2(centroid.y - points[0].y, centroid.x - points[0].x)
	return theta


## This function scales a sequence of 2D points to fit into a 
## square of a given size while preserving its aspect ratio.
func scale_to_square(points: PackedVector2Array, size: float) -> PackedVector2Array:
	var min_x = float("inf")
	var max_x = -float("inf")
	var min_y = float("inf")
	var max_y = -float("inf")
	for p in points:
		min_x = min(min_x, p.x)
		max_x = max(max_x, p.x)
		min_y = min(min_y, p.y)
		max_y = max(max_y, p.y)
	var scale = size / max(max_x - min_x, max_y - min_y)
	var scaled = PackedVector2Array()
	for p in points:
		var x = (p.x - min_x) * scale
		var y = (p.y - min_y) * scale
		scaled.append(Vector2(x, y))
	return scaled


## Rotate a set of 2D points by a given angle around their centroid
func rotate_by(points: PackedVector2Array, theta: float) -> PackedVector2Array:
	# Calculate the centroid of the points
	var centroid = get_centroid(points)
	# Rotate each point around the centroid by the given angle
	var rotated = PackedVector2Array()
	for p in points:
		var v = p - centroid
		var x = v.x * cos(theta) - v.y * sin(theta)
		var y = v.x * sin(theta) + v.y * cos(theta)
		rotated.append(Vector2(x, y) + centroid)
	
	return rotated


## Translates the points by the given offset
func translate_by(points: PackedVector2Array, offset: Vector2) -> PackedVector2Array:
	var translated = PackedVector2Array()
	for p in points:
		translated.append(p + offset)
	return translated

