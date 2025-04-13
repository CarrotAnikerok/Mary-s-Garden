extends TextureRect

@export var ingridient: Ingridient

func _ready():
	if ingridient != null:
		texture = ingridient.texture

func _process(delta):
	print(Input.get_current_cursor_shape())
	if Input.get_current_cursor_shape() == Input.CursorShape.CURSOR_DRAG:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if Input.get_current_cursor_shape() == Input.CursorShape.CURSOR_FORBIDDEN:
		print("true")
		Input.set_custom_mouse_cursor(null, Input.CURSOR_BUSY)
		print(Input.get_current_cursor_shape())
		mouse_default_cursor_shape = CURSOR_BUSY


func _get_drag_data(at_position):
	var texture = TextureRect.new()
	var c = Control.new()
	texture.texture = ingridient.texture
	texture.size = Vector2(50, 50)
	texture.position = Vector2(-100, -100)
	texture.expand_mode
	c.add_child(texture)
	texture.position = -0.5 * texture.size
	set_drag_preview(c)
	return ingridient
	
func _can_drop_data(at_positiocn, data):
	return data is Ingridient
	
func _drop_data(at_position, data):
	ingridient = data
	texture = ingridient.texture
	

	


func _on_bouquet_button_pressed():
	print("bouquet")
