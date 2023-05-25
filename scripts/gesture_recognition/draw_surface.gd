class_name DrawSurface
extends Control

var _color_by_id: Dictionary = {}
var _raw_points: Array[GesturePoint] = []
var _current_stroke_id := 0
var _is_draw_started := false
var is_visible := false
@export var _brush_width: float = 1.0
@export var _start_with_dot := true
@onready var result_label: Label = %Result
# Handle GUI input events.
func _gui_input(event: InputEvent) -> void:
	# Process mouse motion events.

	if event is InputEventMouseMotion:
		# If pressure is sufficient, consider the drawing started.
		if event.pressure >= 0.1:
			_start_drawing(event)
		# If drawing has started and pressure is low, consider the stroke finished.
		elif _is_draw_started:
			_end_drawing()
	# Process mouse button events.
	if event is InputEventMouseButton:
		# If the left mouse button is pressed, perform necessary operations.
		if _is_left_mouse_button_pressed(event):
			pass  # Add any operations to perform on left mouse button press here.


func _unhandled_input(event):
	if event.is_action_pressed("toggle_glyph_drawing_window"):
		is_visible = not is_visible
		if is_visible: self.show()
		else: self.hide()


# Start drawing on sufficient pressure.
func _start_drawing(event: InputEventMouseMotion) -> void:
	# Check if the event position is inside the panel
	if not get_rect().has_point(event.position):
		return
	_is_draw_started = true
	# Add the current point to the raw points list.
	_raw_points.append(GesturePoint.new(event.position.x, event.position.y, _current_stroke_id))
	# Assign a random color to the current stroke if it doesn't have one yet.
	_assign_color_to_current_stroke()
	queue_redraw()


# End drawing on low pressure.
func _end_drawing() -> void:
	_is_draw_started = false
	# Increment the stroke id to start a new stroke on next drawing.
	_current_stroke_id += 1

# Assign a random color to the current stroke.
func _assign_color_to_current_stroke() -> void:
	if not _color_by_id.has(_current_stroke_id):
		_color_by_id[_current_stroke_id] = Color(randf(), randf(), randf())

# Check if the left mouse button is pressed.
func _is_left_mouse_button_pressed(event: InputEventMouseButton) -> bool:
	return event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT



# Note: Theres a program made in godot called Lorien.
# Its worth looking into if you want to improve the drawing.
# https://github.com/mbrlabs/Lorien
func _draw() -> void:
	if _raw_points.is_empty():
		return

	var first_point: GesturePoint = _raw_points.front()
	draw_circle(first_point.as_vector(), _brush_width, _get_color(first_point.id))

	for i in range(1, _raw_points.size()):
		var current_point: GesturePoint = _raw_points[i]
		var previous_point: GesturePoint = _raw_points[i - 1]

		if previous_point.id == current_point.id:
			draw_line(
				previous_point.as_vector(),
				current_point.as_vector(),
				_get_color(previous_point.id),
				_brush_width
			)
		else:
			if _start_with_dot:
				draw_circle(current_point.as_vector(), _brush_width, _get_color(current_point.id))


	for i in range(1, _raw_points.size()):
		var current_point := _raw_points[i]
		var previous_point := _raw_points[i - 1]

		if previous_point.id == current_point.id:
			draw_line(
				previous_point.as_vector(),
				current_point.as_vector(),
				_get_color(previous_point.id),
				1.0
			)
		else:
			draw_circle(current_point.as_vector(), 1.5, _get_color(current_point.id))


func get_points() -> Array[GesturePoint]:
	return _raw_points


func clear() -> void:
	_color_by_id.clear()
	_raw_points.clear()
	queue_redraw()


func _get_color(point_id: int) -> Color:
	return _color_by_id.get(point_id, Color.WHITE)
