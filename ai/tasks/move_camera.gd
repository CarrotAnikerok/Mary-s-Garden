extends BTAction

@export var move_camera_to: float
@export var speed: float = 5

func _enter():
	var ai = agent as AiController
	ai.move_camera(move_camera_to, speed)

func _tick(delta):
	var ai = agent as AiController
	if ai.camera.position.x != move_camera_to:
		return RUNNING
	else:
		return SUCCESS
