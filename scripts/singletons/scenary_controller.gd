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
	if !is_plot_check:
		return
	if (scenary_index < scenary_dict.size() and global.day_count == scenary_dict[scenary_index].day):
		if (global.phase_of_day == scenary_dict[scenary_index].phase):
			if GlobalTimer.phase_time - GlobalTimer.time_left >= scenary_dict[scenary_index].time_in_seconds:
				print("SECONDS " + str(GlobalTimer.phase_time - GlobalTimer.time_left))
				if (!scenary_dict[scenary_index].was_played):
					try_scenary.emit(scenary_dict[scenary_index].scenary)
					scenary_dict[scenary_index].set_played()
					scenary_index += 1
				
	
	#if (global.day_count == 1 and global.phase_of_day == 0):
		#if (GlobalTimer.wait_time - GlobalTimer.time_left) > 5 and !scenary_started:
			#try_scenary.emit(SCENARY_1)
			#scenary_started = true
			#print("EMITTED")
			
