class_name MainCamera
extends Camera2D


@export var main_object: Node2D
var under_ai := false

func _process(delta):
	if !under_ai:
		transform = main_object.transform
