extends Node2D

var save = load("res://custom_resources/plant_saves.tres") as SavedGame
var is_dragging = false
var goal_sums: Array[int] = [0, 70, 200, 300]
@export var plants_to_add: Array[String]
var random_plant_to_add: String

const TIME_OF_PERIOD = 3
const NUMBER_OF_PHASES = 3

var current_scene = 1
var phase_of_day = 0
var day_count = 1

#PlantWindow
var info_check = false
var desc_check = true
var pract_check = false #лучше сделать это явно подругому

func _ready():
	add_to_group("global_world")



func choose_random_plant_to_add():
	if plants_to_add.size() > 0:
		var plant = plants_to_add.pick_random()
		plants_to_add.erase(plant)
		random_plant_to_add = plant
		print("Plant is choisen" + random_plant_to_add)
	else:
		random_plant_to_add = ""
		push_warning("There is no plant in random plants")


func get_today_goal_sum():
	return goal_sums[day_count]


func on_save_game(saved_data:Array[SavedData]):
	print("AM I SAVING??????")
	var my_data = SavedGlobalData.new()
	my_data.day_count = day_count
	my_data.phase_of_day = phase_of_day
	my_data.current_scene = current_scene
	saved_data.append(my_data)
	
	
func on_load_game(saved_data:SavedData):
	print("AM I LOADING??????")
	var my_data:SavedGlobalData = saved_data as SavedGlobalData
	day_count = my_data.day_count
	phase_of_day = my_data.phase_of_day
	current_scene = my_data.current_scene
	
	
