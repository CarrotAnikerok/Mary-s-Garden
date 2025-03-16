extends Sprite2D

@onready var animation = $TimePhaseAnimated
@onready var calendar_label = $"../CalendarButton/CalendarLabel"

func _ready():
	change_phase()
	change_day()
	GlobalTimer.changed_phase.connect(change_phase)
	GlobalTimer.changed_day.connect(change_day)
	

func change_phase():
	match global.phase_of_day:
		0: 
			animation.play("morning_to_day")
			
		1: 
			animation.play("day_to_evenenig")

		2: 
			animation.play("evening_to_night")
			#animation.play("evening_to_night")
		
func change_day():
	calendar_label.text = str(global.day_count)


func _on_time_phase_animated_animation_finished():
	if animation.animation == "evening_to_night":
		animation.play("night_to_morning")
