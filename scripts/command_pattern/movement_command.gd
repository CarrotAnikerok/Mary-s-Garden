class_name MovementCommand
extends Command


class Params:
	var input: float
	
	func _init(input: float) -> void:
		self.input = input


func execute(character: Character, data: Object = null) -> void:
	if character != null:
		character.move(data.input)
