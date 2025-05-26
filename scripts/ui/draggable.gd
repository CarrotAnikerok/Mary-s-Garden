class_name Draggable
extends Node2D

@export var draggable_parent: Node
var selected = false
var rest_point
var rest_nodes: Array[Node]
var current_rest: Node
var mouse_pos
var plant_menu

signal draggable_fell


func start(cell_group_1: String, cell_group_2: String = ""):
	if draggable_parent == null:
		draggable_parent = get_parent()
	current_rest = draggable_parent.get_parent()
	rest_nodes = get_tree().get_nodes_in_group(cell_group_1)
	if cell_group_2 != "":
		rest_nodes.append_array(get_tree().get_nodes_in_group(cell_group_2))
	rest_point = current_rest.global_position
	



func _physics_process(delta):
	if selected:
		draggable_parent.global_position = lerp(draggable_parent.global_position, get_global_mouse_position(), 25 * delta)
		mouse_pos = get_global_mouse_position()
	else:
		draggable_parent.global_position = lerp(draggable_parent.global_position, rest_point, 25 * delta)


func _input(event):
	if (selected):
		if event is InputEventMouseButton:
			if event.is_released():
				selected = false
				global.is_dragging = false
				var shortest_dist  = 14
				for child in rest_nodes:
					if child.visible == true:
						var distance  = global_position.distance_to(child.global_position)
						if distance < shortest_dist and child.get_child_count() == 0:
							if draggable_parent is Plant:
								rest_point = child.global_position
							else:
								rest_point = child.global_position + (child as Panel).size / 2
							current_rest.remove_child(draggable_parent)
							draggable_parent.global_position = Vector2(0, 0)
							current_rest = child
							shortest_dist = distance
							child.add_child(draggable_parent)
							#print("rest point: "  + str(rest_point))
							#print("current rest: "  + str(current_rest.global_position))
							draggable_parent.global_position = mouse_pos
							draggable_fell.emit()
						


func _on_button_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(draggable_parent, "scale", Vector2(1.05, 1.05), 0.2)


func _on_button_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(draggable_parent, "scale", Vector2(1, 1), 0.2)
