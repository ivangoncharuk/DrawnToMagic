extends Control

@export var line_width := 5
@export var line_color := Color(1, 1, 1, 1)

@onready var line : Line2D = %Line

func _ready() -> void:
	line.width = line_width
	line.default_color = line_color

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				line.clear_points()
				line.add_point(line.to_local(event.position))
			else:
				emit_signal("drawing_complete", line.get_points())

	elif event is InputEventMouseMotion:
		if event.get_button_mask() and MOUSE_BUTTON_MASK_LEFT:
			line.add_point(line.to_local(event.position))
