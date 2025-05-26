extends Node2D

@onready var plant_room = $PlantRoom
@onready var hall = $Hall
@onready var scenary_timer = $ScenaryTimer

@export var scene_wait: int #время, которое сйенарий ждет в комнате растений, чтобы проиграться
var waiting_scenary: BehaviorTree

var active_scene: Node2D


func _ready():
	ScenaryController.try_scenary.connect(send_scenary)
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
	
	active_scene = plant_room


func change_scene_to_hall():
	print("go to plant hall")
	var canvas_layers = plant_room.get_children() as Array[CanvasLayer]
	for child in canvas_layers:
		child.visible = false
		
	var hall_canvas_layers = (hall.parallaxes as CanvasLayer).get_children() as Array[CanvasLayer]
	for child in hall_canvas_layers:
		child.visible = true
	hall.visible = true
	
	active_scene = hall
	if (waiting_scenary != null):
		hall.start_scenary(waiting_scenary)


func send_scenary(scenary):
	print("SCENARy SEnded")
	if active_scene == plant_room:
		waiting_scenary = scenary
		scenary_timer.start(scene_wait)
		plant_room.scenary_waiting_on()
		scenary_timer.timeout.connect(plant_room.scenary_waiting_off)
		scenary_timer.timeout.connect(func(): waiting_scenary = null)

	elif active_scene == hall:
		hall.start_scenary(scenary)
