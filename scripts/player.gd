extends CharacterBody2D
class_name Player

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready() -> void:
	set_idle_blend_position(starting_direction)

func _physics_process(_delta: float) -> void:
	var input_direction = get_input_direction()
	update_animation_parameters(input_direction)
	velocity = input_direction * move_speed
	move_and_slide()
	pick_new_state()
	
func get_input_direction() -> Vector2:
	return Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

func update_animation_parameters(move_input: Vector2) -> void:
	if move_input != Vector2.ZERO:
		set_walk_blend_position(move_input)
		set_idle_blend_position(move_input)

func set_idle_blend_position(position: Vector2) -> void:
	animation_tree.set("parameters/Idle/blend_position", position)

func set_walk_blend_position(position: Vector2) -> void:
	animation_tree.set("parameters/Walk/blend_position", position)
		
func pick_new_state() -> void:
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
