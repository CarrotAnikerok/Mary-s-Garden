extends Control

@export var ingridient_res: Resource

@onready var sprite: Sprite2D = $Sprite2D

func  _ready():
	if ingridient_res != null:
		sprite.texture = ingridient_res.texture
	
