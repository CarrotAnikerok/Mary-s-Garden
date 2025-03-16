extends Node2D

var save = load("res://custom_resources/plant_saves.tres") as SavedGame
var is_dragging = false

const TIME_OF_PERIOD = 3
const NUMBER_OF_PHASES = 3
var phase_of_day = 0
var day_count = 0

#PlantWindow
var info_check = false
var desc_check = true

func _ready():
	add_to_group("global_world")

func on_save_game(saved_data:Array[SavedData]):
	print("AM I SAVING??????")
	var my_data = SavedGlobalData.new()
	my_data.day_count = day_count
	my_data.phase_of_day = phase_of_day
	saved_data.append(my_data)
	
	
func on_load_game(saved_data:SavedData):
	print("AM I LOADING??????")
	var my_data:SavedGlobalData = saved_data as SavedGlobalData
	day_count = my_data.day_count
	phase_of_day = my_data.phase_of_day
	
	
