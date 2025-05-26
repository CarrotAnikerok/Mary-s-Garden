extends Sprite2D

@onready var arrow = $Arrow

var arrow_tween: Tween

func _ready():
	start_arrow_animation()
	GlobalTimer.changed_phase.connect(start_arrow_animation)
	ScenaryController.cutscene_started.connect(stop_arrow)
	ScenaryController.cutscene_ended.connect(catch_up)


func start_arrow_animation():
	arrow.rotation = 0
	if arrow_tween:
		arrow_tween.kill()
	arrow_tween = arrow.create_tween()
	arrow_tween.tween_property(arrow, "rotation", arrow.rotation + TAU, GlobalTimer.phase_time)
	

func stop_arrow():
	arrow_tween.kill()


func catch_up(time_to_catch_up: float) -> void:
	if arrow_tween:
		arrow_tween.kill()
	arrow_tween = arrow.create_tween()
	var time_ratio = time_to_catch_up/GlobalTimer.phase_time
	arrow_tween.tween_property(arrow, "rotation", arrow.rotation + time_ratio * TAU, 0.5)
	continue_arrow(GlobalTimer.time_left)


func continue_arrow(time_left: float):
	arrow_tween.tween_property(arrow, "rotation", TAU, time_left)
	
