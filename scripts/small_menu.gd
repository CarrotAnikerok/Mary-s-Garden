extends Control

#Вызов этой штуки в принципе должен ставить всю игру на паузу. 

var game_mene_path = "res://scenes/game_menu/game_menu.tscn"

func _ready():
	get_tree().paused = true

func _on_continue_button_pressed():
	queue_free()
	get_tree().paused = false


func _on_settings_button_pressed():
	pass # Replace with function body.


#сейчас у меня оно меняет сцену, но не убирает другую сцену. плохо.
func _on_main_menu_button_pressed():
	SceneManager.goto_scene(game_mene_path)
	

func _on_exit_button_pressed():
	get_tree().quit()
	
	
