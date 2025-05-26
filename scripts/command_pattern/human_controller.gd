class_name HumanController
extends CharacterController

func _process(_delta):
	var movement_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	movement_command.execute(character, MovementCommand.Params.new(movement_input))
	#когда персонаж контролируется человеокм, он не может выйти за границы экрана
	#все еще в идеале бы сделать это в другое место
	character.position.x = clamp(character.position.x, 10, 470)
