@icon("res://assets/icon/paintbrush.png")
extends Control
class_name Drawing
signal drawing_complete(array : PackedVector2Array)
signal new_point_added

# Exports
@export var line_width := 10
@export var line_color := Color(1, 1, 1, 1)
@export var is_visible_on_ready := false

# Drawing mechanic
@onready var glyph_recognizer : GlyphRecognizer = %GlyphRecognizer
@onready var drawing_area_rect : ReferenceRect = %ReferenceRect

# Label
@onready var spell_name_label : Label = %SpellName
@onready var template_name_label : Label = %TemplateName
@onready var points_count_label : Label =  %PointsCount

# UI
@onready var controls_list_panel: Panel = %ControlList
@onready var save_template_btn : Button = %SaveTemplate
@onready var clear_drawing_btn : Button = %ClearDrawing
@onready var glyph_name_user_entry : TextEdit = %TextEdit
@onready var lines_array :  Array[Line2D] = []

# Global variables
var points_count : int
const POSITIVE_COLOR := Color.LIGHT_GREEN
const NEGATIVE_COLOR := Color.LIGHT_CORAL
var recognition_in_progress: bool = false
var line : Line2D


func _ready() -> void:
#	self.show()
	line = create_new_line(line_width, line_color)
	glyph_recognizer = GlyphRecognizer.new()
#	glyph_recognizer.load_templates("glyph_templates.txt")
	connect_signals()
	line.width = line_width
	line.default_color = line_color
	drawing_area_rect.add_child(line)
	lines_array.append(line)
#	print_debug("lines_array length in _ready(): %10d" % lines_array.size())



func create_new_line(width : float, color : Color) -> Line2D:
	line = Line2D.new()
	line.width = width
	line.default_color = color
	return line


func get_total_point_count() -> int:
	var point_count := 0
	for each_line in lines_array:
		point_count += each_line.get_point_count()
	return point_count


func update_points_count_label() -> void:
	points_count_label.text = str(get_total_point_count())


func connect_signals() -> void:
	new_point_added.connect(update_points_count_label)
	clear_drawing_btn.connect("button_up", clear_lines)
	save_template_btn.connect("button_up", save_template)
	self.connect("drawing_complete", _on_drawing_complete)


func clear_lines() -> void:
	print_debug("points BEFORE CLEAR LINES CALL %d" % get_total_point_count())
	for stroke in lines_array:
		if stroke is Line2D:
			stroke.clear_points()
	lines_array.clear()
	update_points_count_label()

	# Create a new Line2D object
	var new_line = create_new_line(line_width, line_color)
	
	# Check if drawing_area_rect is not null before calling add_child()
	if drawing_area_rect:
		drawing_area_rect.add_child(new_line)
	lines_array.append(new_line)

	print_debug("points AFTER CLEAR LINES CALL %d" % get_total_point_count())


var toggle_visibility = func toggle_visibility() -> void:
	if self.visible == true:
		self.hide()
	else:
		self.show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_glyph_drawing_window"):
		toggle_visibility.call()
	if self.visible:
		handle_mouse_input(event)
		if event.is_action_pressed("recognize_glyph"):
			emit_signal("drawing_complete", get_data())


func get_data() -> PackedVector2Array:
	var points_array := PackedVector2Array()
	for each_line in lines_array:
		points_array.append_array(each_line.get_points())
	return points_array


# todo: break this up into smaller functions
func save_template() -> void:
	# get the name of the new glyph from user text
	var glyph_name = glyph_name_user_entry.text.strip_edges()
	
	if glyph_name != "" and line.get_point_count() <= 10:
		var glyph_template_instance := GlyphTemplate.new()
		# save data into an array
		var template_data := PackedVector2Array(line.get_points())
		glyph_template_instance.data = template_data
		glyph_template_instance.name = glyph_name
		# append the list of templates in GlyphRecognizer as a GlyphTemplate
		glyph_recognizer.templates.append(glyph_template_instance)
		
		# here is where we will execute the saving of the templates 
		# ResourceSaver.save(glyph_template_instance, "res://glyph_templates/random_name_change_this_later.tres")
		ResourceSaver.save(glyph_template_instance, "user://custom_glyph_templates/" + glyph_name + ".tres")

		# then we can load it somewhere else in the game
		glyph_recognizer.load_user_templates()
		# debug
		print_debug("point count: ", get_total_point_count())
		print_debug(template_data)
		
		template_name_label.self_modulate = POSITIVE_COLOR
		template_name_label.text = str("template: [", glyph_name, "] saved!")
	else:
		template_name_label.self_modulate = NEGATIVE_COLOR
		template_name_label.text = "err"
		print_debug("err: glyph_name != \"\" and line.get_point_count() >= 10")


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
	if event.button_mask == MOUSE_BUTTON_MASK_RIGHT: return
	handle_left_mouse_button(event)
#	if event.button_index == MOUSE_BUTTON_MASK_LEFT:
#		pass
#	elif event.button_index == MOUSE_BUTTON_MASK_RIGHT:
#		# Ignore right mouse button events or handle them separately if needed
#		pass
#	else:
#		return

## This function is supposed to be triggered continuously
## while the left mouse button is held down
## and the mouse is moved within the drawing area.
func handle_left_mouse_button(event: InputEventMouseButton) -> void:
	var local_position = get_viewport().get_mouse_position()
	if drawing_area_rect.get_rect().has_point(local_position):
		if event.is_pressed():
			if line.get_point_count() == 0:
				# if this is the first point, just add it directly
				line.add_point(local_position)
				points_count += 1
				new_point_added.emit()
			else:
				# calculate the previous and current point to add intermediate points
				var previous_point = line.points[line.get_point_count() - 1]
				var points_to_add = calculate_lerp_points(previous_point, local_position, 10)
				for point in points_to_add:
					line.add_point(point)
					points_count += 1
					new_point_added.emit()
		else:
			# Create a new Line2D instance and add it to the DrawingLines node
			var new_line = Line2D.new()
			new_line.width = line_width
			new_line.default_color = line_color
			line.get_parent().add_child(new_line)
			lines_array.append(new_line)
			line = new_line


func get_points_to_add(point_count: int, new_point: Vector2) -> Array:
	var last_point = line.get_point_position(point_count - 1)
	var distance : float = new_point.distance_to(last_point)
	var points_to_add := []
	var num_points_to_add = int(distance / line_width)
	if num_points_to_add > 0:
		var increment = 1.0 / num_points_to_add
		for i in range(num_points_to_add):
			var t = (i + 1) * increment
			var interpolated_point = last_point.lerp(new_point, t)
			points_to_add.append(interpolated_point)
	else:
		points_to_add.append(new_point)
	return points_to_add


# helper function to calculate points along a line using linear interpolation
func calculate_lerp_points(start_point: Vector2, end_point: Vector2, count: int) -> Array:
	var points = [start_point]
	var steps = count - 1
	var step_size = 1.0 / float(steps)
	for i in range(steps):
		var t = (i + 1) * step_size
		var lerped_point = start_point.lerp(end_point, t)
		points.append(lerped_point)
	return points


## helper function to handle mouse motion events
## called when the mouse is moved, and adds a point to the drawing line
## if the left mouse button is held down and the mouse is within the drawing area.
func handle_mouse_motion(event: InputEventMouseMotion) -> void:
	if event.get_button_mask() and MOUSE_BUTTON_MASK_LEFT:
		var local_position = get_viewport().get_mouse_position()
		if drawing_area_rect.get_rect().has_point(local_position):
			line.add_point(local_position)
			points_count += 1
			new_point_added.emit()
	else:
		return


func get_local_position(event_position: Vector2, camera: Camera2D) -> Vector2:
	var local_position = camera.get_global_mouse_position().snapped(Vector2(1, 1))
	local_position -= camera.global_position
	local_position /= camera.global_scale
	local_position += event_position
	return local_position


## signals and related methods
func _on_drawing_complete(points: PackedVector2Array) -> void:
#	print_debug(points)
	print_debug("drawing complete about to recognize, this is the point coint: %d" % points_count)
	var glyph_name = glyph_recognizer.recognize(points)
	# Handle the result of the glyph recognition
	if glyph_name != "":
		handle_nonempty_glyph(glyph_name)
	else:
		handle_empty_glyph()


## helper function to handle a non-empty glyph name
func handle_nonempty_glyph(glyph_name: String) -> void:
	if glyph_name in glyph_recognizer.spell_map:
		var spell_name = glyph_recognizer.spell_map[glyph_name]
		spell_name_label.text = str(spell_name)
		spell_name_label.self_modulate = POSITIVE_COLOR
	else:
		print_debug("err, not a spell")
		spell_name_label.self_modulate = NEGATIVE_COLOR


## helper function to handle an empty glyph name
func handle_empty_glyph() -> void:
	print_debug("Error, glyph_name is empty")
	spell_name_label.text = "err: name is empty"
	spell_name_label.self_modulate = NEGATIVE_COLOR
