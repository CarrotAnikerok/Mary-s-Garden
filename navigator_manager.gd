extends Node2D

#мне не нравится это поведение. наверное стоит все же сделать навигатор менеджер синглтеном
var SCENE_HALL = load("res://Scenes/Hall/hall.tscn")
var SCENE_PLANT_ROOM = load("res://Scenes/PlantRoom/plant_room.tscn")
var area_to_plant_room_active

func _input(event):
	if area_to_plant_room_active and event.is_action_pressed("ui_accept"):
		print("gooo ro plant_romm!")
		get_tree().change_scene_to_packed(SCENE_PLANT_ROOM)

func _on_to_hall_button_pressed():
	get_tree().change_scene_to_packed(SCENE_HALL)

func _on_to_plant_room_area_entered(_area):
	print("area to plant room entered!")
	area_to_plant_room_active = true


func _on_to_plant_room_area_area_exited(_area):
	print("area to plant room leaved...")
	area_to_plant_room_active = false
