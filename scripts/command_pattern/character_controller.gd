class_name CharacterController
extends Node

var character: Character

var movement_command := MovementCommand.new()

func _init(character: Character = null) -> void:
	self.character = character
