extends Sprite2D

@onready var animation = $TimePhaseAnimated
@onready var calendar_label = $"../Calendar/CalendarLabel"
@onready var time_clock = $"../TImeClock"

func _ready():
	change_phase()
	change_day()
	GlobalTimer.changed_phase.connect(change_phase)
	GlobalTimer.changed_day.connect(change_day)
	
	

func change_phase():
	var color_tween = get_tree().create_tween()
	match global.phase_of_day:
		0: 
			animation.play("evening_to_night")
			color_tween.tween_property(time_clock, "modulate", Color(0.99, 0.975, 0.554), 0.4)
			#time_clock.modulate = Color(0.54, 1.0, 0.594)
		1: 
			animation.play("morning_to_day")
			color_tween.tween_property(time_clock, "modulate", Color(0.54, 1.0, 0.594), 0.4)
			#time_clock.modulate = Color(0.82, 0.518, 0.426)
		2: 
			animation.play("day_to_evenenig")
			color_tween.tween_property(time_clock, "modulate", Color(0.82, 0.518, 0.426), 0.4)
			#time_clock.modulate = Color(0.99, 0.975, 0.554)
			#animation.play("evening_to_night")
		
func change_day():
	calendar_label.text = str(global.day_count)


func _on_time_phase_animated_animation_finished():
	if animation.animation == "evening_to_night":
		animation.play("night_to_morning")
