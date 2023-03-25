extends Sprite2D

enum DOOR_STATE { OPEN, CLOSED }

@export var door_open_time : float = 1.5


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var timer : Timer = $Timer
@onready var door_area : Area2D = $DoorArea

var current_state = DOOR_STATE.CLOSED

func _ready() -> void:
	door_area.connect("body_entered", _on_door_area_body_changed)
	door_area.connect("body_exited", _on_door_area_body_changed)


func pick_new_state() -> void:
	if current_state == DOOR_STATE.OPEN:
		current_state = DOOR_STATE.CLOSED
		#timer.start(door_open_time)
		#await timer.timeout
		state_machine.travel("door_close")
	elif current_state == DOOR_STATE.CLOSED:
		current_state = DOOR_STATE.OPEN
		#timer.start(door_open_time)
		#await timer.timeout
		state_machine.travel("door_open")


func _on_door_area_body_changed(body: Node2D) -> void:
	if body is PlayerCat and body.is_inside_tree():
		pick_new_state()
