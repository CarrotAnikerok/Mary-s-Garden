extends Node2D

var SCENE_HALL = "res://scenes/hall/hall.tscn"

signal change_scene

func _ready():
	SceneManager.exit.connect(save_plant_room)
	SceneManager.load_plants()

#func _on_to_hall_button_pressed():
	#save_plant_room()
	#SceneManager.goto_scene(SCENE_HALL)
	
func save_plant_room():
	SceneManager.save_plants()


func _on_door_button_pressed():
	save_plant_room()
	global.current_scene = 1
	#SceneManager.goto_scene(SCENE_HALL)
	change_scene.emit()
	print("change scene emitted")
