extends Node


var SCENE_PLANT_ROOM = "res://scenes/plant_room/plant_room.tscn"
var area_to_plant_room_active


func _input(event):
	if area_to_plant_room_active and event.is_action_pressed("ui_accept"):
		print("gooo ro plant_romm!")
		global.current_scene = 0
		await SceneManager.goto_scene(SCENE_PLANT_ROOM)


func _on_to_plant_room_area_entered(_area):
	print("area to plant room entered!")
	area_to_plant_room_active = true
	


func _on_to_plant_room_area_area_exited(_area):
	print("area to plant room leaved...")
	area_to_plant_room_active = false
