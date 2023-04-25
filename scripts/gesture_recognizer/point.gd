class_name Point
extends RefCounted

var pressure := 1
var position :=  Vector2.ZERO
var position_i := Vector2i.ZERO
var stroke_id: int = -1


func _init(pos := Vector2.ZERO, sid := 0, point_pressure := 1) -> void:
	position = pos
	stroke_id = sid
	pressure = point_pressure

func duplicate() -> Point:
	var point := Point.new()
	point.position = position
	point.stroke_id = stroke_id
	return point


func _to_string() -> String:
	return "{%d}(%d, %d)" % [stroke_id, position.x, position.y]
