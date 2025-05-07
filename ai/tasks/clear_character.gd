extends BTAction

@export var character: String

func _enter():
	var characters = (agent as AiController).characters
	if characters.find_child(character, false, false) == null:
		print_debug("character is null")
	else:
		characters.get_node(character).queue_free()
		
		
func _tick(delta):
	return SUCCESS
