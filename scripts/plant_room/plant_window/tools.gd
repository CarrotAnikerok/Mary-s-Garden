extends Control

@onready var active_plant = $"..".active_plant as Plant
@onready var watering_slider_menu = $"../SliderMenu"
@onready var slider = $"../SliderMenu/ColorRect2/WaterAmountHSlider"
@onready var ground_tool = $GroundButton
@onready var ground_time_bar = $GroundButton/TextureProgressBar
@onready var ground_button_texture = $GroundButton/TextureRect

var ground_timer: Timer
var ground_timer_on := false


@export var ground_icons: Dictionary[String, Texture]

signal worked_with_plant()

func _ready():
	ground_time_bar.visible = false
	upfate_info()
	ground_timer.timeout.connect(ground_check)


func _process(delta):
	if ground_timer_on:
		ground_time_bar.value = 100 - (ground_timer.time_left) * 20
	

func _on_watering_can_button_pressed():
	slider.max_value = active_plant.normal_water_amount
	watering_slider_menu.visible = true


func _on_pour_button_pressed():
	active_plant.pour(slider.value)
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.name + " было полито на " + 
	str(slider.value) + "мл")
	worked_with_plant.emit()
	slider.value = 0
	watering_slider_menu.visible = false
	$"../PlantInfo/SoilHumidityInt".text = "%0.2f%%" % active_plant.actual_water_coefficent


func _on_spray_button_pressed():
	active_plant.spray();
	$"../PlantInfo/HumidityInt".text = "%0.2f%%" % active_plant.actual_humidity
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.name + " было опрыснуто")
	worked_with_plant.emit()


func _on_light_button_pressed():
	active_plant.switch_light(3000)
	$"../PlantInfo/LightInt".text = str(active_plant.actual_light_amount)


func _on_ground_button_pressed():
	active_plant.check_ground(5)
	ground_timer_on = true
	if ground_timer_on:
		ground_time_bar.visible = false
		ground_timer_on = false
	else:
		ground_timer_on = true
		ground_time_bar.visible = true


func ground_check():
	ground_timer_on = false
	ground_time_bar.visible = false
	print("Print actual water " + str(active_plant.actual_water_coefficent))
	if active_plant.actual_water_coefficent > 0.7:
		ground_button_texture.texture = ground_icons["full_water"]
		active_plant.ground_check = 2
	elif active_plant.actual_water_coefficent > 0.4:
		ground_button_texture.texture = ground_icons["half_water"]
		active_plant.ground_check = 1
	else:
		ground_button_texture.texture = ground_icons["no_water"]
		active_plant.ground_check = 0

func upfate_info():
	ground_timer = active_plant.ground_timer
	if ground_timer.time_left == 0:
			ground_timer_on = false
			ground_time_bar.visible = false
	else:
		ground_timer_on = true
		ground_time_bar.visible = true
	
		
	match active_plant.ground_check:
		0:
			ground_button_texture.texture = ground_icons["no_water"]
		1:
			ground_button_texture.texture = ground_icons["half_water"]
		2:
			ground_button_texture.texture = ground_icons["full_water"]
		
	
