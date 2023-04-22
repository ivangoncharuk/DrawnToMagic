extends CanvasLayer

@onready var pause_menu: Control = %Paused
@onready var toggle_controls_panel_btn : Button = %Control/ToggleControlsPanel
@onready var controls_panel : Panel = %Controls

func _ready():
	self.show()
	pass
#	toggle_controls_panel_btn.connect("pressed", on_toggle_controls_panel_btn_pressed)


func _input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		call_deferred("_pause")


func _pause() -> void:
	pause_menu.pause()
	get_tree().paused = true
	

func _on_toggle_controls_panel_pressed():
	controls_panel.visible = not controls_panel.visible
