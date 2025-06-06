extends Control


@export var light_icons: Dictionary[String, Resource]
@export var humidity_icons: Dictionary[String, Resource]
@export var state_icons: Array[Resource]

@onready var active_plant = $"../..".active_plant as Plant
@onready var light_icon = $LightIcon
@onready var state_icon = $StateIcon
@onready var humidity_icon = %HumidityIcon



#func _ready():
	#light_icon.texture = light_icons.get("low")
	#light_icon.texture = light_icons.get("hight")
	#light_icon.texture = light_icons2[2]

func _process(delta):
	#light_icon.texture = light_icon.get("mid")
	update_light_icon()
	update_state_icon()
	update_humidity_icon()

func update_light_icon():
	if (active_plant.actual_light_amount < 3000):
		light_icon.texture = light_icons.get("low")
	elif active_plant.actual_light_amount < 5000:
		light_icon.texture = light_icons.get("mid")
	else:
		light_icon.texture = light_icons.get("hight")


func update_state_icon():
	var plant_state = active_plant.plant_state
	state_icon.texture = state_icons[plant_state]


func update_humidity_icon():
	if active_plant.actual_humidity < 0.4:
		humidity_icon.texture = humidity_icons.get("low")
	elif active_plant.actual_humidity < 0.6:
		humidity_icon.texture = humidity_icons.get("medium")
	else:
		humidity_icon.texture = humidity_icons.get("high")
