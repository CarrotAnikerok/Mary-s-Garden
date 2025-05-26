extends Node2D

@export var res: Resource
var cell_group: String



@onready var sprite: Sprite2D = $Sprite2D

func  _ready():
	if res != null:
		sprite.texture = res.texture


#func _on_mouse_entered():
	#name_timer.start(0.8)
	#name_timer.timeout.connect(func(): element_name.visible = true)
#
#
#func _on_mouse_exited():
	#name_timer.stop()
	#element_name.visible = false
