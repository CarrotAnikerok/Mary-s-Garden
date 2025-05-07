extends BTAction


func _enter():
	var ai = agent as AiController
	ai.scenary_end()
	return SUCCESS;
