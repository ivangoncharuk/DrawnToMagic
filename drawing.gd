extends Control

@export var line_width = 10
@export var line_color = Color(1, 1, 1, 1)

@onready var line : Line2D = $Line
@onready var texture_rect : ReferenceRect = %ReferenceRect

func _ready():
	line.width = line_width
	line.default_color = line_color

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_position = _get_local_position(event.position)
			if texture_rect.get_rect().has_point(local_position):
				if event.is_pressed():
					line.clear_points()
					line.add_point(local_position)
				else:
					emit_signal("drawing_complete", line.get_points())

	elif event is InputEventMouseMotion:
		if event.get_button_mask() & MOUSE_BUTTON_MASK_LEFT:
			var local_position = _get_local_position(event.position)
			if texture_rect.get_rect().has_point(local_position):
				line.add_point(local_position)

func _get_local_position(event_position) -> Vector2:
	var local_position = get_viewport().get_canvas_transform().affine_inverse().basis_xform(event_position)
	local_position -= get_global_position()
	return local_position
	
	
	
