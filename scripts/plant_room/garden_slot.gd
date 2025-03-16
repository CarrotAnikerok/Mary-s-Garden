extends StaticBody2D

@export var item: Node2D #даа нужно что то с этим делать
@onready var sprite = $Sprite2D
var can_place = false

func _process(_delta):
	pass
	if global.is_dragging:
		sprite.visible = true
	else:
		pass #item dissapears
		sprite.visible = false
		

func _on_mouse_entered():
	if global.is_dragging:
		#print("can_place!!!!!")
		can_place = true
		

func _on_mouse_exited():
	if global.is_dragging:
		print("cannnot_place :((()))")
		can_place = false
