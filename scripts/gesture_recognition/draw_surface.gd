class_name DrawSurface
extends Control

var _color_by_id: Dictionary = {}
var _raw_points: Array[GesturePoint] = []
var _current_stroke_id := 0
var _is_draw_started := false


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.pressure >= 0.1:
			_is_draw_started = true
			_raw_points.append(
				GesturePoint.new(event.position.x, event.position.y, _current_stroke_id)
			)

			if not _color_by_id.has(_current_stroke_id):
				_color_by_id[_current_stroke_id] = Color(randf(), randf(), randf())

			queue_redraw()
		elif _is_draw_started:
			_is_draw_started = false
			_current_stroke_id += 1
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			pass


# Note: Theres a program made in godot called Lorien.
# Its worth looking into if you want to improve the drawing.
# https://github.com/mbrlabs/Lorien
func _draw() -> void:
	if _raw_points.is_empty():
		return

	var first_point: GesturePoint = _raw_points.front()
	draw_circle(first_point.as_vector(), 1.5, _get_color(first_point.id))

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
