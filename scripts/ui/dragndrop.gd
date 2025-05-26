extends Draggable



func _ready():
	var cell_group = owner.cell_group
	start("zone", cell_group)
	rest_point = current_rest.global_position + (current_rest as Panel).size / 2


func _on_button_button_down():
		selected = true
