extends Control

var _raw_points: Array[Point] = []
var _current_stroke_id := 0
var _is_draw_started := false
var _color_by_id := {0:Color8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))}

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.pressure >= 0.1:
			_is_draw_started = true
			_raw_points.append(Point.new(event.position, _current_stroke_id, event.pressure))
			queue_redraw()
		elif _is_draw_started:
			_is_draw_started = false
			_current_stroke_id += 1
			_color_by_id[_current_stroke_id] = Color8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			pass


func _draw() -> void:
	if _raw_points.is_empty():
		return
	
	var first_point: Point = _raw_points.front()
	var color := Color8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))
	draw_circle(first_point.position, 1.5 * first_point.pressure, color)

	for i in range(1, _raw_points.size()):
		
		var current_point := _raw_points[i]
		var previous_point := _raw_points[i - 1]

		if previous_point.stroke_id == current_point.stroke_id:
			draw_line(previous_point.position, current_point.position, color, 2 * current_point.pressure)
		else:
			color = _color_by_id[current_point.stroke_id]
			draw_circle(current_point.position,  2 * current_point.pressure, color)


func create_gesture() -> Gesture:
	var gesture := Gesture.new()
	gesture.initialize(_raw_points)
	return gesture


func clear() -> void:
	_raw_points.clear()
	_current_stroke_id = 0
	_is_draw_started = false
	queue_redraw.call_deferred()
