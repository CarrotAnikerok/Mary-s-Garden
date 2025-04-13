extends Node2D

@export var draggable_parent: Node
var selected = false
var rest_point
var rest_nodes: Array[Node]
var current_rest: Node
var mouse_pos
var plant_menu

#в итоге тут ненужная функциональность и по хорошему разделить этот класс на два
#для растения и для просто элемента
#но meh


func _ready():
	if draggable_parent == null:
		draggable_parent = get_parent()
	current_rest = draggable_parent.get_parent()
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = current_rest.global_position


func _on_button_button_down():
	if draggable_parent is Plant:
		$ClickTimer.start(0.15)
	else:
		selected = true

	
func _on_button_button_up():
	if draggable_parent is Plant:
		if $ClickTimer.time_left > 0:
			draggable_parent.show_plant_menu()
			plant_menu = true
		


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
					var distance  = global_position.distance_to(child.global_position)
					if distance < shortest_dist:
						rest_point = child.global_position
						current_rest.remove_child(draggable_parent)
						draggable_parent.global_position = Vector2(0, 0)
						current_rest = child
						shortest_dist = distance
						child.add_child(draggable_parent)
						draggable_parent.global_position = mouse_pos

				


func _on_click_timer_timeout():
	if draggable_parent is Plant:
		if plant_menu:
			plant_menu = false
		else:
			selected = true
			global.is_dragging = true


func _on_button_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property(draggable_parent, "scale", Vector2(1.05, 1.05), 0.2)


func _on_button_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property(draggable_parent, "scale", Vector2(1, 1), 0.2)
