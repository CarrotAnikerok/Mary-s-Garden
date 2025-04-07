class_name Plant_Tools
extends Node


var ground_timer: Timer
var ground_check := 0

func _init():
	add_child(Timer.new())
	ground_timer = get_child(-1)
	ground_timer.autostart = true
	print("Ground timer! " + str(ground_timer))

#func _ready():
	#add_child(Timer.new())
	#ground_timer = get_child(-1)
	#print("Ground timer! " + str(ground_timer))


func check_ground(time: float):
	ground_timer.one_shot = true
	if ground_timer.time_left == 0:
		ground_timer.start(time)
	else:
		ground_timer.stop()
