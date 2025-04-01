extends Timer

var all_plants: Array

signal changed_phase()
signal changed_day()

func _ready():
	print("Timer in!")
	print("PHASE RIGHT NOW IS " + str(global.phase_of_day))
	print("DAY RIGHT NOW IS " + str(global.day_count))
	#SceneManager.changed_scene.connect(pause_timer)

func change_phase():
	global.phase_of_day += 1
	if (global.phase_of_day == global.NUMBER_OF_PHASES):
		change_day()
		changed_phase.emit()
	else:
		changed_phase.emit()
	
		
func update_handbook():
	HandbookInfo.change_phase_title()
	
	
func change_day():
	global.phase_of_day = 0
	global.day_count += 1
	changed_day.emit()
	

func update_plants():
	get_tree().call_group("plant", "change_state")
	get_tree().call_group("plant", "dry")
	
	#наверное таймеру нужно какой-то сигнал отправлять чтобы окно растений меняло... состояние...
	#надо придумать, чтобы это происходило естественно... может при выходе из кона? ле вздох
	#может мне стоило сразу делать анимации перехода растений...
	
	
func _on_timeout():
	all_plants = get_tree().get_nodes_in_group("plant")
	print("TIMER OUT")
	for plant in all_plants:
		plant.change_humidity(0.1)
		#print(str(plant) + " " + str(plant.actual_water_coefficent) + " " + str(plant.plant_state))
	update_plants()
	update_handbook()
	change_phase()
	print("PHASE RIGHT NOW IS " + str(global.phase_of_day))
	print("DAY RIGHT NOW IS " + str(global.day_count))
	
func pause_timer():
	print("timer paused")
	paused = true
	
