extends Node2D

var handbook = preload("res://Scenes/PlantRoom/handbook.tscn") as PackedScene

func _on_hand_book_button_pressed():
	var handbook_instance = handbook.instantiate()
	add_child(handbook_instance)
	
