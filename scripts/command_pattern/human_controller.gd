class_name HumanController
extends CharacterController

func _process(_delta):
	var movement_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	movement_command.execute(character, MovementCommand.Params.new(movement_input))
