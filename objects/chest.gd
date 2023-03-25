extends Sprite2D

enum CHEST_STATE { OPEN, CLOSED }

@export var chest_open_time : float = 1.5


@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var timer : Timer = $Timer
@onready var chest_area : Area2D = $ChestArea

var current_state = CHEST_STATE.CLOSED

func _ready() -> void:
	chest_area.connect("body_entered", _on_chest_area_body_changed)
	chest_area.connect("body_exited", _on_chest_area_body_changed)


func pick_new_state() -> void:
	if current_state == CHEST_STATE.OPEN:
		current_state = CHEST_STATE.CLOSED
		timer.start(chest_open_time)
		await timer.timeout
		state_machine.travel("chest_close")
	elif current_state == CHEST_STATE.CLOSED:
		current_state = CHEST_STATE.OPEN
		timer.start(chest_open_time)
		await timer.timeout
		state_machine.travel("chest_open")


func _on_chest_area_body_changed(body: Node2D) -> void:
	if body is PlayerCat and body.is_inside_tree():
		pick_new_state()
