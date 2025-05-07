extends Control

@onready var results = %Results
@onready var sum = %Sum
@onready var advice = %Advice
@onready var new_plant = %NewPlant


@export var advice_text_bad: String
@export var advice_text_good: String

var SCENE_HALL = "res://scenes/hall/hall.tscn"


func _ready():
	get_tree().paused = true
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
	SceneManager.goto_scene(SCENE_HALL)
	queue_free()


func _on_next_day_pressed():
	print_debug("on button predded?")
	results.visible = false
	new_plant.visible = true


func _on_accept_plant_pressed():
	next_day()


func _on_start_over_pressed():
	start_over()
