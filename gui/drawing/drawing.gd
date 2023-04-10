extends Control
class_name Drawing
signal drawing_complete(array)

@export var line_width = 10
@export var line_color = Color(1, 1, 1, 1)

@onready var line : Line2D = %Line
@onready var drawing_area_rect : ReferenceRect = %ReferenceRect
@onready var glyph_recognizer : GlyphRecognizer = %GlyphRecognizer
@onready var spell_label : Label = $SpellName
@onready var save_glyph_btn : Button = %Button
var ctr : int = 0
# Example of how to store the templates as PackedVector2Array

func _ready() -> void:
	self.show()
	line.width = line_width
	line.default_color = line_color
	glyph_recognizer = GlyphRecognizer.new()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_glyph_drawing_window"):
		toggle_visibility()
	if self.visible:
		handle_mouse_input(event)
	if event.is_action_pressed("save_glyph_template"):
		var name_dialog = FileDialog.new()
		name_dialog.set_current_dir(".")
		name_dialog.connect("file_selected", save_template)
		name_dialog.popup_centered()



func toggle_visibility() -> void:
	if self.visible == true:
		self.hide()
	else:
		self.show()


func handle_mouse_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_position = get_local_position(event.position)
			if drawing_area_rect.get_rect().has_point(local_position):
				if event.is_pressed():
					line.clear_points()
					line.add_point(local_position)
				else:
					drawing_complete.emit(line.get_points())
	elif event is InputEventMouseMotion:
		if event.get_button_mask() and MOUSE_BUTTON_MASK_LEFT:
			var local_position = get_local_position(event.position)
			if drawing_area_rect.get_rect().has_point(local_position):
				line.add_point(local_position)


func get_local_position(event_position: Vector2) -> Vector2:
	var local_position = get_viewport(
					).get_canvas_transform(
					).affine_inverse(
					).basis_xform(event_position)
	local_position -= get_global_position()
	return local_position


func save_template(name: String) -> void:
	var points = line.get_points()
	glyph_recognizer.templates[name] = PackedVector2Array(points)


func _on_drawing_complete(points: PackedVector2Array) -> void:
	ctr += 1
	var glyph_name = glyph_recognizer.recognize(points)
	if glyph_name != "" and glyph_name in glyph_recognizer.spell_map:
		var spell_name = glyph_recognizer.spell_map[glyph_name]
		print("Casting spell: ", spell_name, 
			"\nGlyph name: ", glyph_name)
		spell_label.text = str(
			"[  ", ctr,
			" ] Casting spell: ", spell_name, 
			"\nGlyph name: ", glyph_name
			)
	else:
		spell_label.text = "error"
		print("error")



func _on_button_pressed():
	print("Hey")
