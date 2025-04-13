extends Node

var slots: Array[Node]

func _ready():
	slots = get_children(false)
	for slot in slots:
		slot.add_to_group("zone")


func _process(_delta):
	if global.is_dragging:
		for slot in slots:
			slot.self_modulate.a = 0.5
	else:
		for slot in slots:
			slot.self_modulate.a = 0
