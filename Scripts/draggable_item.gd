extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			#offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()# - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			#var tween = get_tree().create_tween()
			if is_inside_dropable:
				var new_slot_parent = body_ref.get_parent()
				get_parent().remove_child(self)
				new_slot_parent.add_child(self)
				self.position = Vector2(12, 12)
				print("yays")
				print(body_ref)
				print(body_ref.position)
				print("Initial pos: ",initialPos)
			else:
				self.position = Vector2(12, 12)
				#tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


#func _on_area_2d_mouse_entered():
	#if not global.is_dragging:
		#draggable = true
		#scale = Vector2(1.05, 1.05)
		#print("can drag!")
#
#
#func _on_area_2d_mouse_exited():
	#if not global.is_dragging:
		#draggable = false
		#scale = Vector2(1, 1)
		#print("cant drag :(")


func _on_area_2d_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body_ref = body
		print("this is it! ", is_inside_dropable)


func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		print("noo ", is_inside_dropable)


func _on_control_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)
		print("can drag!")
		

func _on_control_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)
		print("cant drag :(")
