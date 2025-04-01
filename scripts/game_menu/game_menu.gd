extends Node

var SCENE_HALL = "res://scenes/hall/hall.tscn"
var save_path = "res://SAVES/game_save.tres"
var SCENE_PLANT_ROOM = "res://scenes/plant_room/plant_room.tscn"

func _on_new_game_button_pressed():
	var saved_game:SavedGame = SavedGame.new()
	
	var saved_global_data: Array[SavedData] = []
	var saved_handbook_data: Array[SavedData] = []
	var plants_data: Array[SavedData] = []
	saved_game.global_world = saved_global_data
	saved_game.notes = saved_handbook_data
	saved_game.plant_room = plants_data
	
	ResourceSaver.save(saved_game, save_path)
	SceneManager.goto_scene(SCENE_HALL)


func _on_continue_button_pressed():
	SceneManager.load_game()
	SceneManager.start_scene()


func _on_exit_button_pressed():
	get_tree().quit()
	
