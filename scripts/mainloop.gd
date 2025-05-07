extends Node2D

@onready var plant_room = $PlantRoom
@onready var hall = $Hall

func _ready():
	change_scene_to_hall()
	plant_room.change_scene.connect(change_scene_to_hall)
	hall.change_scene.connect(change_scene_to_plant_room)


func change_scene_to_plant_room():
	print("go to plant room")
	var hall_canvas_layers = (hall.parallaxes as CanvasLayer).get_children() as Array[CanvasLayer]
	for child in hall_canvas_layers:
		child.visible = false
	hall.visible = false
	
	var plant_canvas_layers = plant_room.get_children() as Array[CanvasLayer]
	for child in plant_canvas_layers:
		child.visible = true


func change_scene_to_hall():
	print("go to plant hall")
	var canvas_layers = plant_room.get_children() as Array[CanvasLayer]
	for child in canvas_layers:
		child.visible = false
		
	var hall_canvas_layers = (hall.parallaxes as CanvasLayer).get_children() as Array[CanvasLayer]
	for child in hall_canvas_layers:
		child.visible = true
	hall.visible = true
