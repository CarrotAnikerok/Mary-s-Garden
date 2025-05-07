extends Node2D

@export var parallaxes: CanvasLayer
var SCENE_PLANT_ROOM = "res://scenes/plant_room/plant_room.tscn"
var scene_plant = preload("res://scenes/plant_room/plant_room.tscn").instantiate()
var area_to_plant_room_active

signal change_scene()

func _ready():
	pass
	#get_tree().root.add_child.call_deferred(scene_plant)


func _input(event):
	if area_to_plant_room_active and event.is_action_pressed("ui_accept"):
		#print("gooo ro plant_romm!")
		#global.current_scene = 0
		#await SceneManager.goto_scene(SCENE_PLANT_ROOM)
		print("change scene active")
		change_scene.emit()
		

func _add_a_scene_manually():
	(owner as Node2D).visible = false


func _on_to_plant_room_area_entered(_area):
	print("area to plant room entered!")
	area_to_plant_room_active = true


func _on_to_plant_room_area_area_exited(_area):
	print("area to plant room leaved...")
	area_to_plant_room_active = false


func _on_to_plant_room_area_exited(area):
	pass # Replace with function body.
