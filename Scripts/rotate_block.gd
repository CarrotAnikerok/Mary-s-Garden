extends Node3D

var rotating = false

var prev_mouse_position
var next_mouse_position

func _process(delta):
	pass
	if (Input.is_action_just_pressed("click")):
		rotating = true
		prev_mouse_position = get_viewport().get_mouse_position()
	if (Input.is_action_just_released("click")):
		rotating = false
		
	if (rotating):
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_y((next_mouse_position.x - prev_mouse_position.x) * 1.2 * delta)
		#rotate_z(-(next_mouse_position.y - prev_mouse_position.y) * 0.1 * delta)
		prev_mouse_position = next_mouse_position
