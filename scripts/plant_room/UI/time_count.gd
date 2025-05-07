extends Control

@onready var day_label = $Day
@onready var phase_label =  $Phase

# Called when the node enters the scene tree for the first time.
func _ready():
	change_phase()
	change_day()
	GlobalTimer.changed_phase.connect(change_phase)
	GlobalTimer.changed_day.connect(change_day)
	

func change_phase():
	match global.phase_of_day:
		0: phase_label.text = "Утро"
		1: phase_label.text = "День"
		2: phase_label.text = "Вечер"
		
func change_day():
		day_label.text = "День " + str(global.day_count)
