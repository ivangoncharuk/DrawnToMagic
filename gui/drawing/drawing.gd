@icon("res://assets/icon/paintbrush.png")
extends Control
class_name Drawing
signal drawing_complete(array : PackedVector2Array)
signal new_point_added

# Exports
@export var line_width := 10
@export var line_color := Color(1, 1, 1, 1)
@export var is_visible_on_ready : bool = false

# Drawing mechanic
@onready var glyph_recognizer : GlyphRecognizer = %GlyphRecognizer
@onready var line : Line2D = %Line
@onready var drawing_area_rect : ReferenceRect = %ReferenceRect

# Labels
@onready var spell_name_label : Label = %SpellName
@onready var template_name_label : Label = %TemplateName
@onready var points_count_label : Label = %PointsCount

# UI
@onready var save_template_btn : Button = %SaveTemplate
@onready var clear_drawing_btn : Button = %ClearDrawing
@onready var glyph_name_user_entry : TextEdit = %TextEdit

# Global variables
var drawing_count := 0
const POSITIVE_COLOR := Color.LIGHT_GREEN
const NEGATIVE_COLOR := Color.LIGHT_CORAL


func _ready() -> void:
	self.show()
	line.width = line_width
	line.default_color = line_color
	glyph_recognizer = GlyphRecognizer.new()
#	glyph_recognizer.load_templates("glyph_templates.txt")
	_connect_signals()


func _connect_signals() -> void:
	new_point_added.connect(update_points_count_label)
	clear_drawing_btn.connect("button_up", line.clear_points)
	save_template_btn.connect("button_up", save_template)
	self.connect("drawing_complete", _on_drawing_complete)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_glyph_drawing_window"):
		toggle_visibility()
	if self.visible:
		handle_mouse_input(event)


func save_template() -> void:
	# get the name of the new glyph from user text
	var glyph_name = glyph_name_user_entry.text.strip_edges()
	
	if glyph_name != "" and line.get_point_count() >= 10:
		# make new instance
		var glyph_template_instance := GlyphTemplate.new()
		# save data in array
		var template_data := PackedVector2Array(line.get_points())
		# set template data in the new instance 
		glyph_template_instance.data = template_data
		# set the name in the new instance
		glyph_template_instance.name = glyph_name
		# append the list of templates in GlyphRecognizer as a GlyphTemplate
		glyph_recognizer.templates.append(glyph_template_instance)
		
		# here is where we will execute the saving of the templates 
		# ResourceSaver.save(glyph_template_instance, "res://glyph_templates/random_name_change_this_later.tres")
		
		# then we can load it somewhere else in the game
		
		# debug
		print_debug("point count: ", line.get_point_count())
		print_debug(template_data)
		
		template_name_label.self_modulate = POSITIVE_COLOR
		template_name_label.text = str("template: [", glyph_name, "] saved!")
	else:
		template_name_label.self_modulate = NEGATIVE_COLOR
		template_name_label.text = "err"
		print_debug("err: glyph_name != \"\" and line.get_point_count() >= 10")


func toggle_visibility() -> void:
	if self.visible == true:
		self.hide()
	else:
		self.show()


# Define a function to handle mouse input
func handle_mouse_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		handle_mouse_button(event) # button -> [*]
	elif event is InputEventMouseMotion:
		handle_mouse_motion(event) # motion ~~>


## helper function to handle mouse button events.
## checks whether the event is a mouse button event and calls the
## appropriate function to handle the event based on the button index
func handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_RIGHT:
		handle_right_mouse_button(event)
	elif event.button_index == MOUSE_BUTTON_LEFT:
		handle_left_mouse_button(event)


# handle_left_mouse_button is called when the left mouse button is clicked or
# released, and it adds a point to the line if the mouse is within the drawing
# area and the left mouse button is clicked. This function is triggered only 
# when the left mouse button is clicked or released.
func handle_right_mouse_button(event: InputEventMouseButton) -> void:
	if not event.is_pressed():
		var local_position = get_viewport().get_mouse_position()
		if drawing_area_rect.get_rect().has_point(local_position):
			drawing_complete.emit(line.get_points())
			line.clear_points()
			reset_points_count()


## called when the mouse is moved, 
## adds a point to the line if the left mouse button is held down
## and adds a point if the mouse is within the drawing area.
## This function is triggered continuously
## while the left mouse button is held down
## and the mouse is moved within the drawing area.
func handle_left_mouse_button(event: InputEventMouseButton) -> void:
	var local_position = get_viewport().get_mouse_position()
	if drawing_area_rect.get_rect().has_point(local_position):
		if event.button_index == MOUSE_BUTTON_LEFT:
			line.add_point(local_position)
			new_point_added.emit()



## helper function to handle mouse motion events
## called when the mouse is moved, and adds a point to the drawing line
## if the left mouse button is held down and the mouse is within the drawing area.
func handle_mouse_motion(event: InputEventMouseMotion) -> void:
	if event.get_button_mask() and MOUSE_BUTTON_MASK_LEFT:
		var local_position = get_viewport().get_mouse_position()
		if drawing_area_rect.get_rect().has_point(local_position):
			line.add_point(local_position)
			new_point_added.emit()

### END HANDLE MOUSE

## a function to reset the points count to 0
func reset_points_count() -> void:
	points_count_label.text = "0"



## helper function to update the points count label
func update_points_count_label() -> void:
	points_count_label.text = str(line.get_point_count())


func get_local_position(event_position: Vector2, camera: Camera2D) -> Vector2:
	var local_position = camera.get_global_mouse_position().snapped(Vector2(1, 1))
	local_position -= camera.global_position
	local_position /= camera.global_scale
	local_position += event_position
	return local_position


## signals and related methods

func _on_drawing_complete(points: PackedVector2Array) -> void:
	var glyph_name = glyph_recognizer.recognize(points)
	# Handle the result of the glyph recognition
	handle_glyph_result(glyph_name)
	drawing_count += 1

## helper function for handling what do do with the result logic
func handle_glyph_result(glyph_name: String) -> void:
	if glyph_name != "":
		handle_nonempty_glyph(glyph_name)
	else:
		handle_empty_glyph()


## helper function to handle a non-empty glyph name
func handle_nonempty_glyph(glyph_name: String) -> void:
	if glyph_name in glyph_recognizer.spell_map:
		var spell_name = glyph_recognizer.spell_map[glyph_name]
		spell_name_label.text = str(spell_name)
		spell_name_label.self_modulate = Color.GREEN
	else:
		handle_invalid_glyph(glyph_name)


## helper function to handle an empty glyph name
func handle_empty_glyph() -> void:
	print_debug("Error, glyph_name is empty")
	spell_name_label.text = "err: name is empty"
	spell_name_label.self_modulate = Color.LIGHT_CORAL


## helper function to handle an invalid glyph name
func handle_invalid_glyph(_glyph_name: String) -> void:
	print_debug("err, not a spell")
	spell_name_label.self_modulate = Color.LIGHT_CORAL
