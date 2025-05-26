extends Control

@export var element: Node2D
@onready var name_timer = $NameTimer
@onready var element_name = $ElementName


func  _ready():
	var res = element.res
	if res != null:
		if res is Ingridient:
			print(res.ingridient_name)
			element_name.text = res.ingridient_name
		elif res is PlantProduct:
			element_name.text = res.product_name
	element_name.visible = false


func _on_mouse_entered():
	name_timer.start(0.8)
	name_timer.timeout.connect(func(): element_name.visible = true)


func _on_mouse_exited():
	name_timer.stop()
	element_name.visible = false
