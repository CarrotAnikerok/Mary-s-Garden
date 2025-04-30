class_name Plant_Tools
extends Node

#инфа об ИНСТРУМЕНТАХ растения. то, в каком они состоянии.
#в идеале и их методы. то есть все actual штуки?

var parent_plant: Plant


@export var ground_timer: Timer
var ground_check := 0
var ground_timer_state := GROUND_TIMER_OFF

enum {GROUND_TIMER_ON, GROUND_TIMER_OFF}

signal on_timeout(plant)


func _ready():
	parent_plant = get_parent() as Plant


func start_check_ground(time: float):
	if ground_timer.timeout.is_connected(check_ground):
			ground_timer.timeout.disconnect(check_ground)

	if ground_timer_state == GROUND_TIMER_OFF:
		var water_coeff = parent_plant.actual_water_coefficent
		ground_timer_state = GROUND_TIMER_ON
		ground_timer.start(time)
		ground_timer.timeout.connect(check_ground.bind(water_coeff))
	else:
		ground_timer_state = GROUND_TIMER_OFF
		ground_timer.stop()


func check_ground(water_coefficent: float):
	ground_timer_state = GROUND_TIMER_OFF
	if water_coefficent > 0.7:
		ground_check = 2
	elif water_coefficent > 0.4:
		ground_check = 1
	else:
		ground_check = 0
	on_timeout.emit(parent_plant)


	
	
	

	
