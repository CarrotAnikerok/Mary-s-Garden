extends BTAction


@export var move_to: Vector2 = Vector2(100, 109)
@export var speed: float = 100

func _tick(_delta: float) -> Status:
	var ai = agent as AiController
	var character = ai.mary
	
	var target_pos: Vector2 = move_to
	var current_pos: Vector2 = character.global_position
	
	ai.move_character_to(character, target_pos, _delta, speed)
	if target_pos.distance_squared_to(current_pos) <= 1:
		character.animated_sprite.play("stay")
		return SUCCESS

	return RUNNING
