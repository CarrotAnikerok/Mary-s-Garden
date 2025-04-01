class_name CharAiController
extends CharacterController

var timer: SceneTreeTimer
signal end_of_move


func _ready():
	await move_right(2)
	await move_left(2)
	await move_right(3)
	await move_left(3)
	
	
func _process(delta):
	print(timer.time_left)


func move_right(seconds: int):
	timer = get_tree().create_timer(seconds)
	timer.timeout.connect(stop)
	if timer.time_left > 0:
		movement_command.execute(character, MovementCommand.Params.new(1.0))
	await timer.timeout


func move_left(seconds: int):
	timer = get_tree().create_timer(seconds)
	timer.timeout.connect(stop)
	if timer.time_left > 0:
		movement_command.execute(character, MovementCommand.Params.new(-1.0))
	await timer.timeout


func stop():
	print("STOP TIMER")
	movement_command.execute(character, MovementCommand.Params.new(0.0))
	
