extends Node2D

@onready var pause_menu: Control = %Paused

func _input(event):
	if event.is_action_released("pause"):
		call_deferred("_pause")
		
func _pause():
	pause_menu.pause()
	get_tree().paused = true
