extends GutTest

# Declare variables
var drawing: Drawing

# Setup methods
#func before_all():
#	gut.p("Runs once before all tests")

func before_each():
#	gut.p("Runs before each test.")
	drawing = Drawing.new()
	var new_line = Line2D.new()
	drawing.lines_array.append(new_line)


func after_each():
#	gut.p("Runs after each test.")
	drawing.queue_free()

func after_all():
	gut.p("END OF TESTING")
#	gut.p("Runs once after all tests")


# Test methods
func test_points_count():
	drawing.lines_array = [
		Line2D.new(),
		Line2D.new(),
		Line2D.new()
	]
	drawing.lines_array[0].add_point(Vector2(0, 0))
	drawing.lines_array[0].add_point(Vector2(1, 1))
	drawing.lines_array[1].add_point(Vector2(2, 2))
	drawing.lines_array[1].add_point(Vector2(3, 3))
	drawing.lines_array[2].add_point(Vector2(4, 4))
	drawing.lines_array[2].add_point(Vector2(5, 5))
	
	var expected_points_count = 6
	var actual_points_count = drawing.get_total_point_count()
	assert_eq(actual_points_count, expected_points_count, "Points count should be equal to the expected count")


# Test toggle_visibility method
func test_toggle_visibility():
	# Set up the test
	drawing.visible = true

	# Call the method
	drawing.toggle_visibility.call()

	# Check the result
	assert_false(drawing.visible, "Drawing should be hidden")

	# Call the method again
	drawing.toggle_visibility.call()

	# Check the result
	assert_true(drawing.visible, "Drawing should be visible")


func test_calculate_lerp_points() -> void:
	var start_point = Vector2(0, 0)
	var end_point = Vector2(10, 10)
	var count = 6

	var actual_points = drawing.calculate_lerp_points(start_point, end_point, count)
	var expected_points = [
		Vector2(0, 0),
		Vector2(2, 2), 
		Vector2(4, 4), 
		Vector2(6, 6), 
		Vector2(8, 8), 
		Vector2(10, 10)
	]
	for i in range(count):
		actual_points[i] = actual_points[i].round()
	
	assert_eq(actual_points, expected_points, "Points calculated using linear interpolation should match the expected points")


# Test handle_nonempty_glyph method
func test_handle_nonempty_glyph():
	# Set up the test
	var glyph_name = "glyph1"
	drawing.glyph_recognizer = GlyphRecognizer.new()
	drawing.glyph_recognizer.spell_map = {
		"glyph1": "spell1"
	}
	drawing.spell_name_label = Label.new()

	# Call the method
	drawing.handle_nonempty_glyph(glyph_name)

	# Check the result
	assert_eq(drawing.spell_name_label.text, "spell1", "Label should display the correct spell name")
	assert_eq(drawing.spell_name_label.self_modulate, Color.LIGHT_GREEN, "Label self_modulate should be LIGHT_GREEN")

# Test handle_empty_glyph method
func test_handle_empty_glyph():
	# Set up the test
	drawing.spell_name_label = Label.new()

	# Call the method
	drawing.handle_empty_glyph()

	# Check the result
	assert_eq(drawing.spell_name_label.text, "err: name is empty", "Label should display the error message")
	assert_eq(drawing.spell_name_label.self_modulate, Color.LIGHT_CORAL, "Label self_modulate should be LIGHT_CORAL")


func test_first_line_after_clearing_canvas():
	# Draw a line
	gut.p("points before adding points %d (should be 0)" % drawing.get_total_point_count())
	drawing.lines_array[0].add_point(Vector2(0, 0))
	drawing.lines_array[0].add_point(Vector2(1, 1))
	drawing.lines_array[0].add_point(Vector2(3, 1))
	drawing.lines_array[0].add_point(Vector2(4, 1))
	drawing.lines_array[0].add_point(Vector2(5, 1))
	drawing.lines_array[0].add_point(Vector2(7, 1))
	drawing.lines_array[0].add_point(Vector2(1, 32))
	drawing.lines_array[0].add_point(Vector2(1, 12))
	
	# Clear the canvas
	gut.p("points after adding: %d (should be 8)" % drawing.get_total_point_count())
	
	drawing.clear_lines()
	gut.p("points after clearing: %d (should be 0)" % drawing.get_total_point_count())
	
	# Draw a new line
	drawing.lines_array[0].add_point(Vector2(2, 2))
	drawing.lines_array[0].add_point(Vector2(43, 3))
	drawing.lines_array[0].add_point(Vector2(12, 1))
	drawing.lines_array[0].add_point(Vector2(1, 2))
	drawing.lines_array[0].add_point(Vector2(3, 1))
	drawing.lines_array[0].add_point(Vector2(1, 1))
	drawing.lines_array[0].add_point(Vector2(4, 1))
	
	gut.p("after drawing new line... points = %d" % drawing.get_total_point_count())
	
	# Check if the new line is registered
	var expected_points_count = 7
	var actual_points_count = drawing.get_total_point_count()
	
	gut.p("expected %d" % expected_points_count)
	gut.p("actual %d" %actual_points_count)
	
	assert_eq(actual_points_count, expected_points_count, "Points count should be equal to the expected count after clearing the canvas and drawing a new line")


func test_add_point_to_line():
	gut.p("lines_array length before adding point: %10d" % drawing.lines_array.size()) # Add this line
	drawing.lines_array[0].add_point(Vector2(0, 0))
	gut.p("lines_array length after adding point: %10d" % drawing.lines_array.size()) # Add this line
	assert_eq(drawing.lines_array[0].get_point_count(), 1)


