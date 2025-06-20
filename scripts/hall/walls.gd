extends Node2D

@onready var wall_1 = $Wall1
@onready var wall_2 = $Wall2

var is_in_wall_2: bool = false
var scenary_passed: bool = false
var charac: Character




func _input(event):
	#that one scene with mark and kris
	if is_in_wall_2 and event.is_action_pressed("ui_accept") and !scenary_passed:
		print("emit scenary!")
		ScenaryController.try_next_scenary()
		scenary_passed = true


#func _on_wall_1_area_entered(area: Area2D):
	#charac = area.get_parent() as Character
	#
	#var movement_input =  Input.get_action_strength("move_left")
	#charac._controller.movement_command.execute(charac, MovementCommand.Params.new(movement_input))
#
	#print("is area!" + str(position.x))
	#if charac is Player:
		#print("is player!" + str(charac.position.x))
		#charac.position.x = wall_2.position.x + 17
		#
#
#
func _on_wall_2_area_entered(area):
	charac = area.get_parent() as Character
	if charac is Player:
		print("in wall")
		is_in_wall_2 = true


func _on_wall_2_area_exited(area):
	charac = area.get_parent() as Character
	if charac is Player:
		print(" not in in wall")
		is_in_wall_2 = false
