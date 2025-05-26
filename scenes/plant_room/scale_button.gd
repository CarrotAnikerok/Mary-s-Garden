extends Node

@export var parent: Control

func _ready():
	parent.mouse_entered.connect(entered)
	parent.mouse_exited.connect(exited)
	

func entered():
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "scale", Vector2(1.1, 1.1), 0.2)


func exited():
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "scale", Vector2(1, 1), 0.2)
