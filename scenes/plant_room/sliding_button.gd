extends Node

@export var button: Control
@export var to_position: Vector2
@export var time: float

var start_position: Vector2


func _ready():
	start_position = button.position
	button.mouse_entered.connect(entered)
	button.mouse_exited.connect(exited)
	

func entered():
	start_position = button.position
	var tween = get_tree().create_tween()
	tween.tween_property(button, "position", button.position + to_position, time)
	await tween.finished


func exited():
	if is_inside_tree():
		var tween = get_tree().create_tween()
		tween.tween_property(button, "position", start_position, time)
		await tween.finished
		
