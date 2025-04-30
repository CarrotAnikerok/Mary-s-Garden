class_name AiController
extends Node

@export var camera: MainCamera
@export var arin: Character
@export var mary: Character
@export var scarlett: Character
@export var mark: Character
@export var kris: Character

var timer: SceneTreeTimer

var movement_command := MovementCommand.new()

func _ready():
	#mary.set_controller(HumanController.new(mary))
	scenary_1()


func move_right(character, seconds: float):
	timer = get_tree().create_timer(seconds)
	timer.timeout.connect(stop.bind(character))
	if timer.time_left > 0:
		movement_command.execute(character, MovementCommand.Params.new(1.0))
	await timer.timeout


func move_left(character, seconds: float):
	timer = get_tree().create_timer(seconds)
	timer.timeout.connect(stop.bind(character))
	if timer.time_left > 0:
		movement_command.execute(character, MovementCommand.Params.new(-1.0))
	await timer.timeout


func stay(character, seconds: float):
	timer = get_tree().create_timer(seconds)
	timer.timeout.connect(stop.bind(character))
	if timer.time_left > 0:
		movement_command.execute(character, MovementCommand.Params.new(0.0))
	await timer.timeout


func stop(character):
	print("STOP TIMER")
	movement_command.execute(character, MovementCommand.Params.new(0.0))


func move_camera(move_to: float):
	camera.under_ai = true
	var tween = create_tween()
	await tween.tween_property(camera, "position", Vector2(move_to, 108), 5)
	

func return_control():
	mary.set_controller(HumanController.new(mary))
	camera.under_ai = false
	
	
func scenary_1():
	move_camera(330)
	await move_right(mary, 2)
	await move_left(mary, 2)
	await move_right(mary, 1)
	await move_left(mary, 1)
	move_right(mary, 1)
	await move_left(scarlett, 1)
	await stay(mary, 1.4)
	move_right(mary, 1.1)
	await move_right(arin, 2.35)
	await move_left(arin, 0.01)
	SignulBus.emit_signal("display_dialog", "first_dialog")
	await SignulBus.dialog_ended
	return_control() #сигнал об окончании сценария. сигнал об окончании диалога
