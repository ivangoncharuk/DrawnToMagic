@tool
extends PanelContainer


@onready var _draw_surface: DrawSurface = %DrawSurface
@onready var _save_button: Button = %SaveButton
@onready var _name_field: LineEdit = %NameField


func _ready() -> void:
	_save_button.pressed.connect(
		func():
			var gesture = Gesture.new(_name_field.text, _draw_surface.get_points())
			gesture._name = _name_field.text
			ResourceSaver.save(gesture, "res://scripts/gesture_recognition/templates/%s.tres" % _name_field.text)
			_draw_surface.clear()
			_name_field.clear()
	)
