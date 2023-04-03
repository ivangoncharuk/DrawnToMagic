extends Node2D

var spinning := false
var is_toggle_modulate := false

@onready var sprite : Sprite2D = %Icon
@onready var rotate_btn = %RotateButton
@onready var toggle_modulate_btn = %ToggleModulate
@onready var spin_boxes : HBoxContainer = %SpinBoxes
@onready var red : SpinBox = %Red
@onready var green : SpinBox = %Green
@onready var blue : SpinBox = %Blue
@onready var alpha : SpinBox = %Alpha



func _ready() -> void:
	rotate_btn.connect("pressed", _on_btn_pressed)
	toggle_modulate_btn.connect("pressed", toggle_modulate)
	for box in spin_boxes.get_children():
		box.connect("value_changed", _on_modulate_sprite_btn_pressed)
func _process(delta: float) -> void:
	if spinning:
		sprite.rotate(delta)


func _on_btn_pressed() -> void:
	spinning = not spinning


func toggle_modulate() -> void:
	is_toggle_modulate = not is_toggle_modulate

func _on_modulate_sprite_btn_pressed(value) -> void:
	if not is_toggle_modulate: return
	var new_color := Color(red.value, green.value, blue.value, alpha.value)
	sprite.set_self_modulate(new_color)
	# print_debug(new_color)
