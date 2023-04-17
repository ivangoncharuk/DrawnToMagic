extends HBoxContainer

# Customize these values to change the hover effect
const HOVER_SCALE = Vector2(1.2, 1.2)
const HOVER_MOVE = Vector2(0, -5)

func _ready():
	# Connect mouse_entered and mouse_exited signals for each RichTextLabel
	for label in get_children():
		label.connect("mouse_entered", _on_label_mouse_entered(label))
		label.connect("mouse_exited", _on_label_mouse_exited(label))

func _on_label_mouse_entered(label: RichTextLabel):
	# Animate the letter when the mouse enters
	label.rect_scale = HOVER_SCALE
	label.rect_position += HOVER_MOVE

func _on_label_mouse_exited(label: RichTextLabel):
	# Reset the letter animation when the mouse exits
	label.rect_scale = Vector2(1, 1)
	label.rect_position -= HOVER_MOVE
