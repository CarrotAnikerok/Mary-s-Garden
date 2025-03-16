extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref: StaticBody2D
var offset: Vector2
var initialPos: Vector2
var item: Plant

func _ready():
	item = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if draggable:
		if global.is_dragging == true:
				item.global_position = get_global_mouse_position()

func _input(_event):
	if draggable:
		if Input.is_action_just_pressed("click"):
			$ClickTimer.start(0.05)
		if Input.is_action_pressed("click"):
			if $ClickTimer.get_time_left() == 0.0:
				global.is_dragging = true
		elif Input.is_action_just_released("click") and global.is_dragging:
			global.is_dragging = false
			var old_slot_parent = item.get_parent()
			if is_inside_dropable and body_ref.get_child_count() == 2:
				var new_slot_parent = body_ref
				item.get_parent().remove_child(item)
				new_slot_parent.add_child(item)
				item.position = Vector2(0, 0)
				item.place_update() #должноо ли оно быть здесь?
			else:
				old_slot_parent.add_child(item)
				item.position = Vector2(0, 0)
				


func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		item.scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		item.scale = Vector2(1, 1)
		

func _on_dropable_area_body_entered(body:StaticBody2D): #how it fucking works why is this so buggy
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body_ref = body
		#print("Entered to " + str(body_ref))


func _on_dropable_area_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		#print("Escaped from " + str(body_ref))
