extends Control

func _ready():
	hide()

func _unhandled_input(event) -> void:
	if event.is_action_released("pause"):
		if get_tree().paused:
			_resume()
		else:
			pause()

func pause():
	print("paused")
	show()
	get_tree().paused = true

func _resume():
	hide()
	get_tree().paused = false
