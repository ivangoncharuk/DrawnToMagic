extends Node

class_name DrawingLines

var lines := []
var current_line : Line2D
var drawing_lines_color = Color(1, 1, 1, 1)
var drawing_lines_width = 10


func _ready() -> void:
	init_current_line()

func init_current_line() -> void:
	current_line = Line2D.new()
	current_line.default_color = drawing_lines_color
	current_line.width = drawing_lines_width
	add_child(current_line)

func add_point(point: Vector2) -> void:
	current_line.add_point(point)


# Add the set_width function
func set_width(width: int) -> void:
	drawing_lines_width = width
	for line in lines:
		line.width = width
	current_line.width = width

# Add the set_color function
func set_color(color: Color) -> void:
	drawing_lines_color = color
	for line in lines:
		line.default_color = color
	current_line.default_color = color


func get_size() -> int:
	var size = 0
	for line in lines:
		size += line.get_point_count()
	return size



