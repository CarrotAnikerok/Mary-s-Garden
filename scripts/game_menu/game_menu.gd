extends Node

var SCENE_HALL = "res://scenes/hall/hall.tscn"
var save_path = "res://SAVES/game_save.tres"
var SCENE_PLANT_ROOM = "res://scenes/plant_room/plant_room.tscn"

func _on_new_game_button_pressed():
	var saved_game:SavedGame = SavedGame.new()
	ResourceSaver.save(saved_game, save_path)
	SceneManager.goto_scene(SCENE_HALL)


func _on_continue_button_pressed():
	SceneManager.goto_scene(SCENE_PLANT_ROOM)


func _on_exit_button_pressed():
	get_tree().quit()
