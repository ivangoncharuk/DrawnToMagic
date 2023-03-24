extends CharacterBody2D
class_name PlayerCat

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

# parameters/Idle/blend_position

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready() -> void:
	animation_tree.set("parameters/Idle/blend_position", starting_direction)

func _physics_process(_delta) -> void:
	# input direction
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# print(input_direction)
	
	update_animation_parameters(input_direction)
	velocity = input_direction * move_speed
	move_and_slide()
	pick_new_state()
	
func update_animation_parameters(move_input: Vector2) -> void:
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
func pick_new_state() -> void:
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
