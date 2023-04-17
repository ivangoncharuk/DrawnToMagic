extends CanvasLayer

@onready var pause_menu: Control = %Paused

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		call_deferred("_pause")

func _pause() -> void:
	pause_menu.pause()
	get_tree().paused = true
