extends Node2D

@export var plant_product_res: Resource

@onready var sprite: Sprite2D = $Sprite2D

func  _ready():
	if plant_product_res != null:
		sprite.texture = plant_product_res.texture
	
