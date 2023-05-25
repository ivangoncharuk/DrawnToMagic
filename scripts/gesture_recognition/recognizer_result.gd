class_name RecognizerResult
extends RefCounted

var name: StringName
var score: float = 0.0
var time: float = 0.0

func _init(p_name: StringName, p_score: float, p_ms: float):
	name = p_name
	score = p_score
	time = p_ms
