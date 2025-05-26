extends BTAction

@export var time_spent: int

func _enter():
	var ai = agent as AiController
	ai.scenary_end(time_spent)
	return SUCCESS;
