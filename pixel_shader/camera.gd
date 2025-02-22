@tool
extends Camera3D

@export var post_processing := true:
	set(p):
		if p:
			$Postprocess.show()
			post_processing = p
			var a = Vector3(-1, 1, 0).normalized()
			var b = Vector3(1, 0, 0).normalized()
			print("dot: ", a.dot(b))
		else:
			$Postprocess.hide()
			post_processing = p
			
func _process(_delta):
	pass
	#if Input.is_action_pressed("ui_right"):
		#position.x += 0.5
	#elif Input.is_action_pressed("ui_left"):
		#position.x -= 0.5
	#elif Input.is_action_pressed("ui_up"):
		#position.y += 0.5
	#elif Input.is_action_pressed("ui_down"):
		#position.y -= 0.5
	#elif Input.is_action_pressed("ui_text_dedent"):
		#size += 0.5
	#elif Input.is_action_pressed("ui_text_indent"):
		#size -= 0.5
		
		
