extends Control

@onready var active_plant = $"../..".active_plant as Plant
@onready var watering_slider_menu = $"../SliderMenu"
@onready var slider = $"../SliderMenu/ColorRect2/WaterAmountHSlider"
@onready var ground_tool = $GroundButton
@onready var ground_time_bar = $GroundButton/TextureProgressBar
@onready var ground_button_texture = $GroundButton/TextureRect
@onready var light_button_texture = $LightButton/LightTexture

var plant_tools: Plant_Tools

var ground_timer: Timer
var ground_check_plant: Plant

@export var ground_icons: Dictionary[String, Texture]
@export var light_icons: Dictionary[String, Texture]

signal worked_with_plant()

func _ready():
	ground_time_bar.visible = false
	update_info()


func _process(delta):
	if plant_tools.ground_timer_state == plant_tools.GROUND_TIMER_ON:
		ground_time_bar.value = 100 - (ground_timer.time_left) * 20
	

func _on_watering_can_button_pressed():
	slider.max_value = active_plant.normal_water_amount
	watering_slider_menu.visible = true


func _on_pour_button_pressed():
	active_plant.pour(slider.value)
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.public_name + " полили на " + 
	str(slider.value) + "мл")
	worked_with_plant.emit()
	slider.value = 0
	watering_slider_menu.visible = false


func _on_spray_button_pressed():
	active_plant.spray();
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.public_name + " побрызгали")
	worked_with_plant.emit()


func _on_light_button_pressed():
	active_plant.switch_light(3000)
	change_light_icon()
	worked_with_plant.emit()


func _on_ground_button_pressed():
	ground_check_plant = active_plant
	plant_tools.start_check_ground(5)
	if plant_tools.ground_timer_state == plant_tools.GROUND_TIMER_ON:
		ground_time_bar.visible = true
	else:
		ground_time_bar.visible = false
		

func _on_scissors_button_pressed():
	print("scissors pressed")
	if active_plant.can_give_flowers == true:
		if active_plant.plant_ingridient_flower != null:
			print("ingidient added")
			PlantProductInfo.add_ingridient(active_plant.plant_ingridient_flower)
			HandbookInfo.add_note("plant_action", active_plant.plant_name, "Получили цветок с " + active_plant.public_name)
			active_plant.can_give_flowers = false
	else:
		print("ingidient not added")
		HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.public_name + " не цветет")
	if active_plant.can_give_leaves == true:
		if active_plant.plant_ingridient_leaves != null:
			PlantProductInfo.add_ingridient(active_plant.plant_ingridient_leaves)
			HandbookInfo.add_note("plant_action", active_plant.plant_name, "Получили листья c " + active_plant.public_name)
			active_plant.can_give_leaves = false
	else:
		HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.public_name + " не имеет достаточно листьев")
	worked_with_plant.emit()

#то есть мне нужно запоминать, на каком растении началась работа. то есть СИГНАЛ пусть дает
#мне об этом информацию
func on_ground_check_end(plant):
	add_ground_note(plant)
	worked_with_plant.emit()
	if plant_tools.ground_timer.time_left == 0:
		ground_time_bar.visible = false
		change_tothspick_icon()


func update_info():
	active_plant = $"../..".active_plant as Plant
	plant_tools = active_plant.plant_tools
	ground_timer = plant_tools.ground_timer
	if plant_tools.on_timeout.is_connected(on_ground_check_end):
			plant_tools.on_timeout.disconnect(on_ground_check_end)
	plant_tools.on_timeout.connect(on_ground_check_end)
	change_tothspick_icon()
	change_light_icon()
	
	if plant_tools.ground_timer_state == plant_tools.GROUND_TIMER_OFF:
		ground_time_bar.visible = false
	else:
		ground_time_bar.visible = true
		print("update info?")


func change_tothspick_icon():
	match plant_tools.ground_check:
		0:
			ground_button_texture.texture = ground_icons["no_water"]
		1:
			ground_button_texture.texture = ground_icons["half_water"]
		2:
			ground_button_texture.texture = ground_icons["full_water"]


func change_light_icon():
	if active_plant.light_on:
		light_button_texture.texture = light_icons["light_on"]
	else:
		light_button_texture.texture = light_icons["light_off"]


func add_ground_note(plant):
	match plant.plant_tools.ground_check:
		0:
			HandbookInfo.add_note("plant_action", plant.plant_name, "Палочка для " + plant.name + " совсем сухая")
		1:
			HandbookInfo.add_note("plant_action", plant.plant_name, "Палочка для " + plant.name + " полувлажная")
		2:
			HandbookInfo.add_note("plant_action", plant.plant_name, "Палочка для " + plant.name + " очень влажная")
		
	
