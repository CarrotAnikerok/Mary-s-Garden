extends Timer

var all_plants: Array
const END_DAY_MENU = preload("res://scenes/game_menu/end_day_menu.tscn") as PackedScene

signal changed_phase()
signal changed_day()

func _ready():
	print("PHASE RIGHT NOW IS " + str(global.phase_of_day))
	print("DAY RIGHT NOW IS " + str(global.day_count))
	#SceneManager.changed_scene.connect(pause_timer)


func change_phase():
	global.phase_of_day += 1
	if (global.phase_of_day == global.NUMBER_OF_PHASES):
		changed_phase.emit()
		get_parent().add_child(END_DAY_MENU.instantiate())
		END_DAY_MENU.instantiate()
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



func _on_timeout():
	all_plants = get_tree().get_nodes_in_group("plant")
	print("TIMER OUT")
	update_plants()
	for plant in all_plants:
		plant.change_humidity(0.1)
		#print(str(plant) + " " + str(plant.actual_water_coefficent) + " " + str(plant.plant_state))
	update_handbook()
	change_phase()
	print("PHASE RIGHT NOW IS " + str(global.phase_of_day))
	print("DAY RIGHT NOW IS " + str(global.day_count))


func pause_timer():
	print("timer paused")
	paused = true
	
