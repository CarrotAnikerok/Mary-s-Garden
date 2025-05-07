extends BTAction

@export var character: PackedScene
@export var place: Vector2 = Vector2(500, 108)

func _enter():
	var characters = (agent as AiController).characters
	var character_instance = character.instantiate() as Node2D
	characters.add_child(character_instance)
	character_instance.global_position = place


func _tick(delta):
	return SUCCESS
