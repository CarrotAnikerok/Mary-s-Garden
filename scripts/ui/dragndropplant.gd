extends Draggable


func _ready():
	start("plant_cell")
	rest_point = current_rest.global_position
	draggable_fell.connect(draggable_parent.place_update)


func _on_button_button_down():
	$ClickTimer.start(0.15)

	
func _on_button_button_up():
	if $ClickTimer.time_left > 0:
		draggable_parent.show_plant_menu()
		plant_menu = true


func _on_click_timer_timeout():
	if draggable_parent is Plant:
		if plant_menu:
			plant_menu = false
		else:
			selected = true
			global.is_dragging = true
