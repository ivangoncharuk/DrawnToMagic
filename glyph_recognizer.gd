extends Node
class_name GlyphRecognizer

# Example of how to store the templates as PackedVector2Array
var templates = {
	"line": PackedVector2Array([
		Vector2(10, 0),
		Vector2(20, 0),
		Vector2(30, -1),
		Vector2(40, 0),
		Vector2(50, 1),
		Vector2(60, 0),
		Vector2(70, 0),
		Vector2(80, 0),
		Vector2(90, 0),
	]),
	"square": PackedVector2Array([
		Vector2(23.75, 98.5), Vector2(23.75, 97), Vector2(23.75, 91.5), Vector2(23.75, 84.75), Vector2(23.75, 79.5), Vector2(23.75, 72.75), Vector2(23.75, 66.5), Vector2(23.75, 61.25), Vector2(23.75, 57.25), Vector2(23.75, 53.25), Vector2(23.75, 49.5), Vector2(23.75, 46.75), Vector2(23.75, 43.25), Vector2(23.75, 41), Vector2(23.75, 39), Vector2(23.75, 38.75), Vector2(23.75, 38.75), Vector2(24, 38.75), Vector2(24.75, 38.75), Vector2(26.5, 38.75), Vector2(29.5, 38.75), Vector2(33.75, 38.75), Vector2(39.25, 38.75), Vector2(45.75, 38.5), Vector2(53, 38.5), Vector2(60.25, 38.25), Vector2(67, 38.25), Vector2(73.25, 38), Vector2(79.25, 37.5), Vector2(83, 37.5), Vector2(86.25, 37.5), Vector2(88.25, 37.5), Vector2(89.25, 37.5), Vector2(89.75, 37.5), Vector2(90, 37.5), Vector2(89.75, 37.5), Vector2(89.5, 38.75), Vector2(89, 41.25), Vector2(88, 45.5), Vector2(87.25, 51), Vector2(86.75, 57), Vector2(86.5, 62.75), Vector2(86.5, 69), Vector2(86.5, 75.5), Vector2(86.5, 81), Vector2(86.5, 84.5), Vector2(86.5, 87.5), Vector2(86.5, 89.5), Vector2(86.5, 90.25), Vector2(86.5, 90.75), Vector2(86.5, 91), Vector2(86.5, 91.25), Vector2(86.5, 91.25), Vector2(86.5, 91.5), Vector2(86.5, 91.5), Vector2(83.5, 92.25), Vector2(77.5, 93.5), Vector2(68.25, 95.25), Vector2(60.5, 96.5), Vector2(51.25, 97.5), Vector2(43, 98), Vector2(37, 98.75), Vector2(32, 99), Vector2(27.75, 99), Vector2(23.75, 99),
		Vector2(23.75, 99), Vector2(21.5, 99), Vector2(19.5, 99), Vector2(17.75, 98.5), Vector2(17.5, 98.25), Vector2(17.25, 98.25), Vector2(17.25, 98), Vector2(17.5, 98), Vector2(18, 98),
	]),
	"star": PackedVector2Array([
		Vector2(45, 5), Vector2(55, 5), Vector2(50, 20),
		Vector2(55, 35), Vector2(45, 35), Vector2(50, 20),
		Vector2(55, 5), Vector2(65, 5), Vector2(70, 20),
		Vector2(75, 5), Vector2(85, 5), Vector2(75, 20),
		Vector2(85, 35), Vector2(75, 35), Vector2(70, 20),
		Vector2(65, 35), Vector2(55, 35), Vector2(60, 50),
		Vector2(50, 65), Vector2(40, 50), Vector2(45, 35),
		Vector2(35, 35), Vector2(25, 35), Vector2(35, 20),
		Vector2(30, 5), Vector2(40, 5)
	]),
	"circle": circle_points(50, 200)
}

func circle_points(radius, num_points) -> PackedVector2Array:
	var points: PackedVector2Array
	for i in range(num_points):
		var angle = 2 * PI * i / num_points
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		points.append(Vector2(x, y))
	return points

func recognize(points: PackedVector2Array) -> String:
	var best_match = ""
	var best_score = -1.0
	for glyph_name in templates:
		var score = compare_glyphs(points, templates[glyph_name])
		if score > best_score:
			best_score = score
			best_match = glyph_name
	return best_match

func compare_glyphs(glyph1: PackedVector2Array, glyph2: PackedVector2Array) -> float:
	var n = glyph1.size()
	var m = glyph2.size()

	var DTW = PackedFloat32Array()
	for i in range(m+1):
		DTW.append(float("inf"))
	DTW[0] = 0
	
	var prev
	var current
	for i in range(1, n+1):
		prev = DTW[0]
		DTW[0] = float("inf")
		for j in range(1, m+1):
			current = DTW[j]
			# print("i: ", i, "\nj: ", j, "\ncurrent: ", current)
			DTW[j] = min(DTW[j], DTW[j-1], prev) + (glyph1[i-1] - glyph2[j-1]).length_squared()
			prev = current
	
	return sqrt(DTW[m] / (n + m))



