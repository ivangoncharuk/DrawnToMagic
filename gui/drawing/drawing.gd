extends Control
signal drawing_complete(array)
@export var line_width = 10
@export var line_color = Color(1, 1, 1, 1)

@onready var line : Line2D = %Line
@onready var texture_rect : ReferenceRect = %ReferenceRect
@onready var glyph_recognizer : GlyphRecognizer = %GlyphRecognizer

var spell_map = {
	"square": "(square) SQ",
	"line": "(line) L",
	"star": "(star) R",
	"circle": "(circle) C"
}

func _ready() -> void:
	self.show()
	line.width = line_width
	line.default_color = line_color
	glyph_recognizer = GlyphRecognizer.new()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var local_position = _get_local_position(event.position)
			if texture_rect.get_rect().has_point(local_position):
				if event.is_pressed():
					line.clear_points()
					line.add_point(local_position)
				else:
					drawing_complete.emit(line.get_points())
	elif event is InputEventMouseMotion:
		if event.get_button_mask() and MOUSE_BUTTON_MASK_LEFT:
			var local_position = _get_local_position(event.position)
			if texture_rect.get_rect().has_point(local_position):
				line.add_point(local_position)
#				print(line.get_points(), "\n")


func _on_drawing_complete(points: PackedVector2Array) -> void:
	# Recognize the glyph using the saved image
	var glyph_name = glyph_recognizer.recognize(points)
	if glyph_name != "" and glyph_name in spell_map:
		var spell_name = spell_map[glyph_name]
		print("Casting spell: ", spell_name)
		print("glyph_name: ", glyph_name)
	else:
		print("error")

func _get_local_position(event_position: Vector2) -> Vector2:
	var local_position = get_viewport().get_canvas_transform().affine_inverse().basis_xform(event_position)
	local_position -= get_global_position()
	return local_position


