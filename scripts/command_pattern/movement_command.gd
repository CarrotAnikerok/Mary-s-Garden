class_name MovementCommand
extends Command


class Params:
	var input: float
	
	func _init(_input: float) -> void:
		self.input = _input


func execute(character: Character, data: Object = null) -> void:
	if character != null:
		character.move(data.input)
