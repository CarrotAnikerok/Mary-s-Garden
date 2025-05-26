extends Control

@onready var results = %Results
@onready var sum = %Sum
@onready var advice = %Advice
@onready var new_plant = %NewPlant
@onready var plant_texture = %PlantTexture
@onready var plant_title = %PlantTitle



@export_multiline var advice_text_bad: String
@export_multiline var advice_text_good: String
@export var plant_textures: Dictionary[String, IndividualPlantParameters]

var SCENE_HALL = "res://scenes/hall/hall.tscn"


func _ready():
	get_tree().paused = true
	new_plant.visible = false
	results.visible = true
	sum.text = str(GameWallet.get_day_income())
	if GameWallet.get_day_income() > global.get_today_goal_sum():
		advice.text = advice_text_good
	else:
		advice.text = advice_text_bad
		
	


func start_over():
	queue_free()
	get_tree().paused = false


func next_day():
	get_tree().paused = false
	GlobalTimer.change_day()
	#SceneManager.goto_scene(SCENE_HALL)
	queue_free()


func _on_next_day_pressed():
	print_debug("on button predded?")
	global.choose_random_plant_to_add()
	var plant_to_add = global.random_plant_to_add
	print_debug("Plant_to_add" + plant_to_add)
	plant_title.text = (plant_textures.get(plant_to_add) as IndividualPlantParameters).public_name + "!"
	plant_texture.texture = (plant_textures.get(plant_to_add) as IndividualPlantParameters).sprite
	results.visible = false
	new_plant.visible = true


func _on_accept_plant_pressed():
	next_day()


func _on_start_over_pressed():
	start_over()
