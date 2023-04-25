extends Node

var gesture_recognizer := GestureRecognizer.new()
@onready var draw_surface = $DrawSurface


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			pass


func _ready() -> void:
	var gesture := Gesture.new()
	var plus_glyph: Array[Point] = []
	var line_glyph: Array[Point] = []
	var step := .05
	var length := 10000

	# Constructs horizontal line
	for i in length:
		plus_glyph.append(Point.new(Vector2(i * step, .5), 0))
	
	# Construct vertical line
	for i in length:
		plus_glyph.append(Point.new(Vector2(length / 2.0, i * step), 1))
	
	for i in length:
		line_glyph.append(Point.new(Vector2(i * step, .5), 0))

	gesture.name = "Plus"
	gesture.initialize(line_glyph)
	gesture_recognizer.templates.append(gesture)
	
	gesture = Gesture.new() 
	gesture.name = "Line"
	gesture.initialize(plus_glyph)
	gesture_recognizer.templates.append(gesture)