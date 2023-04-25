extends Control

var _raw_points: Array[Point] = []
var _current_stroke_id := 0
var _is_draw_started := false

func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        if event.pressure >= 0.1:
            _is_draw_started = true
            _raw_points.append(Point.new(event.position, _current_stroke_id, event.pressure))
            queue_redraw()
        elif _is_draw_started:
            _is_draw_started = false
            _current_stroke_id += 1
    if event is InputEventMouseButton:
        if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
            pass


func _draw() -> void:
    if _raw_points.is_empty():
        return
    
    var first_point: Point = _raw_points.front()
    draw_circle(first_point.position, 1.5, Color.WHITE)

    for i in range(1, _raw_points.size()):
        var current_point := _raw_points[i]
        var previous_point := _raw_points[i - 1]

        if previous_point.stroke_id == current_point.stroke_id:
            draw_line(previous_point.position, current_point.position, Color.WHITE, 2 * current_point.pressure)
        else:
            draw_circle(current_point.position,  2 * current_point.pressure, Color.WHITE)


func create_gesture() -> Gesture:
    var gesture := Gesture.new()
    gesture.initialize(_raw_points)
    return gesture


