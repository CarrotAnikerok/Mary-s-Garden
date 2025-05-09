extends Node2D

var SCENE_HALL = "res://scenes/hall/hall.tscn"
var current_plants: Array[Plant]
@export var plants_to_add: Dictionary[String, PackedScene]
@onready var garden_slots = %GardenSlots

signal change_scene

func _ready():
	sort_plants()
	SceneManager.exit.connect(save_plant_room)
	SceneManager.load_plants()
	GlobalTimer.changed_day.connect(add_random_plant_to_scene)

#func _on_to_hall_button_pressed():
	#save_plant_room()
	#SceneManager.goto_scene(SCENE_HALL)
	
func add_random_plant_to_scene():
	var plant_name = global.random_plant_to_add
	var plant = plants_to_add.get(plant_name)
	if plant != null:
		add_new_plant(plant)
	else:
		print("PLANTS ARE OVER")



func sort_plants():
	for slot in garden_slots.get_children():
		if slot.get_child_count() > 0:
			print(str(slot) + " found a child " + slot.get_child(0).name)
			current_plants.append(slot.get_child(0))


func add_new_plant(plant: PackedScene):
	var plant_inst = plant.instantiate()
	var table_slots = get_tree().get_nodes_in_group("table")
	for slot in table_slots:
		if slot.get_child_count() == 0:
			slot.add_child(plant_inst)
			plant_inst.owner = self
			current_plants.append(plant_inst)
			break


func save_plant_room():
	SceneManager.save_plants()


func _on_door_button_pressed():
	save_plant_room()
	global.current_scene = 1
	#SceneManager.goto_scene(SCENE_HALL)
	change_scene.emit()
	print("change scene emitted")



func _on_button_pressed():
	GlobalTimer.change_phase()
