extends HBoxContainer

# Customize these values to change the hover effect
const HOVER_SCALE = Vector2(1.2, 1.2)
const HOVER_MOVE = Vector2(0, -5)

func _ready():
	add_labels("Drawn to Magic")
	# Connect mouse_entered and mouse_exited signals for each Control
	for custom_control in get_children():
		custom_control.connect("mouse_entered", _on_control_mouse_entered(custom_control))
		custom_control.connect("mouse_exited", _on_control_mouse_exited(custom_control))


func add_labels(title_text: String):
	for letter in title_text:
		var custom_control = Control.new()
		custom_control.mouse_filter = Control.MOUSE_FILTER_PASS
		add_child(custom_control)

		var label = Label.new()
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		label.text = letter
		custom_control.add_child(label)


func _on_control_mouse_entered(custom_control: Control):
	# Animate the letter when the mouse enters
	var label = custom_control.get_child(0)
	if label:
		label.scale = HOVER_SCALE
		label.position += HOVER_MOVE


func _on_control_mouse_exited(custom_control: Control):
	# Reset the letter animation when the mouse exits
	var label = custom_control.get_child(0)
	label.scale = Vector2(1, 1)
	label.position -= HOVER_MOVE
