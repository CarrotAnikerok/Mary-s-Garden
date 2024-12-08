extends Node2D

@export var active_plant: Plant

func _on_button_pressed():
	active_plant.waterPlant()
