extends Node2D

@onready var wall_1 = $Wall1
@onready var wall_2 = $Wall2

var is_in_wall_2: bool = false
var scenary_passed: bool = false
var char: Character

const SCENARY_2 = preload("res://scenary/scenary_2.tres")

func _input(event):
	if is_in_wall_2 and event.is_action_pressed("ui_accept") and !scenary_passed:
		print("emit scenary!")
		ScenaryController.try_scenary.emit(SCENARY_2)
		scenary_passed = true


#func _on_wall_1_area_entered(area: Area2D):
	#char = area.get_parent() as Character
	#
	#var movement_input =  Input.get_action_strength("move_left")
	#char._controller.movement_command.execute(char, MovementCommand.Params.new(movement_input))
#
	#print("is area!" + str(position.x))
	#if char is Player:
		#print("is player!" + str(char.position.x))
		#char.position.x = wall_2.position.x + 17
		#
#
#
func _on_wall_2_area_entered(area):
	char = area.get_parent() as Character
	if char is Player:
		print("in wall")
		is_in_wall_2 = true


func _on_wall_2_area_exited(area):
	char = area.get_parent() as Character
	if char is Player:
		print(" not in in wall")
		is_in_wall_2 = false
