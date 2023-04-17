extends VBoxContainer

@export var gameplay_scene : PackedScene
@export var settings_scene : PackedScene

@onready var start_btn : Button = %Start
@onready var settings_btn : Button = %Settings
@onready var quit_btn : Button = %Quit


func _ready() -> void:
#	get_children()[0].grab_focus()
	_connect_signals()
	if !OS.has_feature("pc"):
		quit_btn.hide()


func _connect_signals() -> void:
	start_btn.connect("pressed", _on_start_pressed)
	settings_btn.connect("pressed", _on_settings_pressed)
	quit_btn.connect("pressed", _on_quit_pressed)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_packed(settings_scene)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(gameplay_scene)

