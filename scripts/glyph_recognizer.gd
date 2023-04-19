@icon("res://assets/icon/glyph_recognizer_icon.png")
extends Node
class_name GlyphRecognizer

@export var templates : Array [GlyphTemplate] = []

## GLYPH RECOGNITION LOGIC

var spell_map = {
	"s": "LETTER S",
	"a": "LETTER A",
	"b": "LETTER B"
}


@export var glyph_templates : Array[GlyphTemplate] = []


func _ready() -> void:
	load_user_templates()


func load_user_templates() -> void:
	var dir = DirAccess.open("user://custom_glyph_templates")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var loaded_template = ResourceLoader.load("user://custom_glyph_templates/" + file_name) as GlyphTemplate
				templates.append(loaded_template)
			file_name = dir.get_next()
		dir.list_dir_end()



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

	var resampled1 = GlyphUtils.resample(glyph1, template.size())
	var resampled2 = GlyphUtils.resample(glyph2, template.size())

	# Calculate the indicative angle of the points

	var theta1 = GlyphUtils.indicative_angle(resampled1)
	var theta2 = GlyphUtils.indicative_angle(resampled2)
	resampled1 = rotate_by(resampled1, -theta1)
	resampled2 = rotate_by(resampled2, -theta2)

	var scale1 = scale_to_square(resampled1, template[1].distance_to(template[2]))
	var scale2 = scale_to_square(resampled2, template[1].distance_to(template[2]))


	var centroid1 = GlyphUtils.get_centroid(scale1)
	var centroid2 = GlyphUtils.get_centroid(scale2)
	
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
	var centroid = GlyphUtils.get_centroid(points)
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

