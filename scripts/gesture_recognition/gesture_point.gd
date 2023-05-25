class_name GesturePoint
extends Resource

var x: float = 0
var y: float = 0
var id: int
var int_x = 0  # for indexing into the LUT
var int_y = 0  # for indexing into the LUT


func _init(p_x: float, p_y: float, p_id: int):
	x = p_x
	y = p_y
	id = p_id


func as_vector() -> Vector2:
	return Vector2(x, y)
