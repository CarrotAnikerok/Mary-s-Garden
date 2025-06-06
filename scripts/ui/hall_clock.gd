extends AnimatedSprite2D

@onready var clock_button = %ClockButton


func _on_clock_button_pressed():
	print_debug("On clock button pressed: scenary in phase " + str(ScenaryController.has_next_scenary_in_phase()))
	if ScenaryController.has_next_scenary_in_phase():
		var scenary_start_time = ScenaryController.get_scenary_start_time()
		GlobalTimer.start(GlobalTimer.time_left - scenary_start_time)
		GlobalTimer.wait_time = GlobalTimer.phase_time
		ScenaryController.try_next_scenary()
	else:
		GlobalTimer._on_timeout()
		GlobalTimer.start(GlobalTimer.phase_time)
