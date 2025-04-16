extends Draggable


func _ready():
	start("zone")
	rest_point = current_rest.global_position + Vector2(5, 5)


func _on_button_button_down():
		selected = true
