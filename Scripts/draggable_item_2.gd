extends Control

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var item

func _ready():
	item = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		if global.is_dragging == true:
				item.global_position = get_global_mouse_position()

func _input(event):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			$ClickTimer.start(0.05)
		if Input.is_action_pressed("click"):
			if $ClickTimer.get_time_left() == 0.0:
				global.is_dragging = true
		elif Input.is_action_just_released("click") and global.is_dragging:
			global.is_dragging = false
			if is_inside_dropable:
				var new_slot_parent = body_ref
				item.get_parent().remove_child(item)
				print("This is too bdy ref" + str(new_slot_parent))
				new_slot_parent.add_child(item)
				item.position = body_ref.position
				#print("yays")
			else:
				item.position = initialPos


func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		item.scale = Vector2(1.05, 1.05)
#
#
func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		item.scale = Vector2(1, 1)
		#print("cant drag :(")

func _on_dropable_area_body_entered(body:StaticBody2D):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body_ref = body
		print("This is body" + str(body_ref))
		print("this is it! ", is_inside_dropable)


func _on_dropable_area_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		print("noo ", is_inside_dropable)
