extends Panel

@export var item: Node2D #даа нужно что то с этим делать
var can_place = false

func _process(delta):
	pass
	if global.is_dragging:
		visible = true
	else:
		pass
		#visible = false
		

func _on_mouse_entered():
	focus_mode = 1
	if global.is_dragging:
		print("can_place!!!!!")
		can_place = true
		

func _on_mouse_exited():
	if global.is_dragging:
		print("cannnot_place :((()))")
		can_place = false
