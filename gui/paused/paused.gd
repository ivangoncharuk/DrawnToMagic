extends Control

func _ready():
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		if get_tree().paused:
			_resume()
		else:
			pause()

func pause():
	%PauseOptions.get_children()[0].grab_focus()
	show()
	get_tree().paused = true

func _resume():
	hide()
	get_tree().paused = false
