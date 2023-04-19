extends GutTest

# Declare variables
var drawing: Drawing
# Setup methods
func before_each():
	drawing = Drawing.new()

func after_each():
	drawing.queue_free()

func after_all():
	gut.p("END OF TESTING")

# Test resample function
func test_resample():
	var input_points = PackedVector2Array()
	input_points.append(Vector2(0, 0))
	input_points.append(Vector2(1, 1))
	input_points.append(Vector2(2, 2))
	input_points.append(Vector2(3, 3))
	input_points.append(Vector2(4, 4))

	var resampled_points = GlyphUtils.resample(input_points, 5)

	# Check if the distances between the expected and actual points are small enough
	var tolerance = 1e-6
	for i in range(resampled_points.size()):
		var distance = (resampled_points[i] - input_points[i]).length()
		assert_true(distance < tolerance, "Resampled points should be within the tolerance range of expected points")



# Test indicative_angle function
func test_indicative_angle():
	var input_points = PackedVector2Array([
		Vector2(0, 0),
		Vector2(1, 1),
		Vector2(2, 2),
		Vector2(3, 3),
		Vector2(4, 4)
	])

	var expected_angle = atan2(2 - 0, 2 - 0)
	var actual_angle = GlyphUtils.indicative_angle(input_points)

	assert_eq(actual_angle, expected_angle, "Indicative angle should match the expected angle")
