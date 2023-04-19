extends Node

class_name GlyphUtils

## This function calculates the indicative angle (in radians) of a sequence
## of 2D points relative to their centroid. 
static func indicative_angle(points: PackedVector2Array) -> float:
	if points.size() == 0:
		print_debug("ERROR: points.size() should be > 0, \npoints.size() = ", points.size())
		return 0.0  # Return a default value, e.g., 0.0, or choose another appropriate value
	
	var centroid = get_centroid(points)
	var theta = atan2(centroid.y - points[0].y, centroid.x - points[0].x)
	return theta
	
## Calculates the centroid of a sequence of 2D points
static func get_centroid(points: PackedVector2Array) -> Vector2:
	var acc = Vector2.ZERO
	for p in points:
		acc += p
	# Divide the accumulated vector by the number of points to obtain the centroid vector
	return acc / points.size()

# This uniformly resamples an input sequence of 2D points
## to a new length by adding interpolated points along the
## original path. 
static func resample(points: PackedVector2Array, n: int) -> PackedVector2Array:
	var step = points.size() / (n - 1)
	var resampled = PackedVector2Array()
	var tolerance = 1e-6  # Add a small tolerance value

	if points.size() == 0:
		print_debug("ERROR: points.size() should be > 0, \npoints.size() = ", points.size())
		pass
	resampled.append(points[0])
	var i = 1
	var t = 0.0
	while i < points.size() and resampled.size() < n:
		var v = points[i] - points[i-1]
		var d = v.length()
		if t + d >= step - tolerance:  # Add tolerance to the comparison
			var x = points[i-1] + ((step - t) / d) * v
			resampled.append(x)
			t = 0.0
		else:
			t += d
		i += 1
	if resampled.size() < n:
		resampled.append(points[points.size() - 1])
	return resampled

