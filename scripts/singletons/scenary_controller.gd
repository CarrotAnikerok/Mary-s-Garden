extends Node

@export var scenary_dict: Array[ScenaryTime]
@export var is_plot_check: bool = true


#элемент, чекающий день, фазу и время
signal try_scenary(scenary)
signal cutscene_started()
signal cutscene_ended(spent_time)

var scenary_index: int = 0

var scenary_started: bool = false

func _process(delta):
	if scenary_index >= scenary_dict.size():
		return
	if !is_plot_check:
		return
	if scenary_dict[scenary_index].was_played:
		scenary_index += 1
		return
	if (global.day_count == scenary_dict[scenary_index].day):
		if (global.phase_of_day == scenary_dict[scenary_index].phase):
			if GlobalTimer.phase_time - GlobalTimer.time_left >= scenary_dict[scenary_index].time_in_seconds:
				print("SECONDS " + str(GlobalTimer.phase_time - GlobalTimer.time_left))
				try_next_scenary()
				
	
func try_next_scenary() -> void:
	print_debug("Try next scenary: " + str(scenary_index))
	try_scenary.emit(scenary_dict[scenary_index].scenary)
	scenary_dict[scenary_index].set_played()
	scenary_index += 1


func has_next_scenary_in_phase() -> bool:
	if scenary_index >= scenary_dict.size():
		return false
	if (global.phase_of_day != scenary_dict[scenary_index].phase):
		false
	return true


func get_scenary_start_time() -> float:
	return scenary_dict[scenary_index].time_in_seconds
