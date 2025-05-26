class_name ScenaryTime
extends Resource

enum phases {MORNING, DAY, EVENING}

@export var day: int
@export var phase: phases
@export var time_in_seconds: float
@export var scenary: BehaviorTree
@export var was_played: bool


func set_played():
	was_played = true
