extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref: StaticBody2D
var offset: Vector2
var initialPos: Vector2
var item: Plant

func _ready():
	item = get_parent()

func _process(_delta):
	if draggable:
		if global.is_dragging == true:
				item.global_position = get_global_mouse_position()


#func _input(_event):
	#if draggable:
		#if Input.is_action_pressed("click"):
			#if $ClickTimer.get_time_left() == 0.0:
				#print("still pressed!")
				#global.is_dragging = true
		#elif Input.is_action_just_released("click") and global.is_dragging:
			#global.is_dragging = false
			#var old_slot_parent = item.get_parent()
			#if is_inside_dropable and body_ref.get_child_count() == 2:
				#var new_slot_parent = body_ref
				#item.get_parent().remove_child(item)
				#new_slot_parent.add_child(item)
				#item.position = Vector2(0, 0)
				#item.place_update() #должноо ли оно быть здесь?
			#else:
				##old_slot_parent.add_child(item)
				#var tween = get_tree().create_tween()
				#tween.tween_property(item, "position", Vector2(0, 0), 0.1)
				


func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		var tween = get_tree().create_tween()
		tween.tween_property(item, "scale", Vector2(1.05, 1.05), 0.2)


func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		var tween = get_tree().create_tween()
		tween.tween_property(item, "scale", Vector2(1, 1), 0.2)
		

func _on_dropable_area_body_entered(body:StaticBody2D): #how it fucking works why is this so buggy
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body_ref = body
		#print("Entered to " + str(body_ref))


func _on_dropable_area_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		#print("Escaped from " + str(body_ref))


func _on_plant_button_down():
	$ClickTimer.start(0.15)


func _on_plant_button_up():
	if $ClickTimer.get_time_left() > 0:
		item.show_plant_menu()
	elif global.is_dragging == true:
		global.is_dragging = false
		var old_slot_parent = item.get_parent()
		if is_inside_dropable and body_ref.get_child_count() == 2:
			var new_slot_parent = body_ref
			item.get_parent().remove_child(item)
			new_slot_parent.add_child(item)
			item.position = Vector2(0, 0)
			item.place_update() #должноо ли оно быть здесь?
		else:
			#old_slot_parent.add_child(item)
			var tween = get_tree().create_tween()
			tween.tween_property(item, "position", Vector2(0, 0), 0.1)
			
func set_dragging():
	if draggable:
		if Input.is_action_pressed("click"):
			global.is_dragging = true
		else:
			global.is_dragging = false
		

func _on_click_timer_timeout():
	set_dragging()
