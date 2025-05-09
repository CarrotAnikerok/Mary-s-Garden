extends Control

var handbook = preload("res://scenes/plant_room/handbook.tscn") as PackedScene
const PLANT_WORKSHOP = preload("res://scenes/plant_room/plant_workshop/plant_workshop.tscn") as PackedScene
@onready var time_animation = $DateButton/TImeClock/Arrow/AnimationPlayer
@onready var date_button = $DateButton
@onready var handbook_button = $Panel/HandbookButton
@onready var door_button = $Panel/DoorButton
@onready var panel = $Panel


func  _ready():
	time_animation.speed_scale = 1 / GlobalTimer.wait_time
	time_animation.seek(1 - GlobalTimer.time_left / GlobalTimer.wait_time)

func _on_handbook_button_pressed():
	var handbook_instance = handbook.instantiate()
	get_parent().add_child(handbook_instance)


func _on_door_button_pressed():
	pass # Replace with function body.


func _on_panel_mouse_entered():
	var tween_menu = get_tree().create_tween()
	print("PANEL MOUSE ENTERED")
	handbook_button.visible = true
	door_button.visible = true
	tween_menu.tween_property(date_button, "scale", Vector2(1.1, 1.1), 0.2)
	tween_menu.parallel().tween_property(panel, "size", Vector2(80, 29), 0.2)
	tween_menu.parallel().tween_property(handbook_button, "position", Vector2(40, 2), 0.2)
	tween_menu.parallel().tween_property(door_button, "position", Vector2(60, 2), 0.2)


func _on_panel_mouse_exited():
	print("PANEL MOUSE EXITED")
	var tween_menu = get_tree().create_tween()
	tween_menu.tween_property(date_button, "scale", Vector2(1, 1), 0.2)
	tween_menu.parallel().tween_property(panel, "size", Vector2(40, 29), 0.2)
	tween_menu.parallel().tween_property(handbook_button, "position", Vector2(4, 2), 0.2)
	tween_menu.parallel().tween_property(door_button, "position", Vector2(4, 2), 0.2)
	#tween.tween_callback(toggle_visibility)
	
	
func toggle_visibility():
	if (handbook_button.visible == true):
		handbook_button.visible = false
		door_button.visible = false
	else:
		handbook_button.visible = true
		door_button.visible = true


func _on_handbook_button_mouse_entered():
	var tween_handbook = get_tree().create_tween()
	tween_handbook.tween_property(handbook_button, "scale", Vector2(0.9, 0.9), 0.2)


func _on_handbook_button_mouse_exited():
	var tween_handbook = get_tree().create_tween()
	tween_handbook.tween_property(handbook_button, "scale", Vector2(0.8, 0.8), 0.2)
	

func _on_door_button_mouse_entered():
	var tween_door = get_tree().create_tween()
	tween_door.tween_property(door_button, "scale", Vector2(0.9, 0.9), 0.2)


func _on_door_button_mouse_exited():
	var tween_door = get_tree().create_tween()
	tween_door.tween_property(door_button, "scale", Vector2(0.8, 0.8), 0.2)


func _on_button_pressed():
	GlobalTimer._on_timeout()


func _on_workshop_button_pressed():
	get_parent().add_child(PLANT_WORKSHOP.instantiate())
