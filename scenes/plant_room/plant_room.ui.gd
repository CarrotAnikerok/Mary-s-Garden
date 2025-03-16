extends Control

var handbook = preload("res://scenes/plant_room/handbook.tscn") as PackedScene
@onready var time_animation = $ColorRect/AnimationPlayer

func  _ready():
	time_animation.speed_scale = 1 / GlobalTimer.wait_time

func _on_handbook_button_pressed():
	var handbook_instance = handbook.instantiate()
	get_parent().add_child(handbook_instance)


func _on_door_button_pressed():
	pass # Replace with function body.
