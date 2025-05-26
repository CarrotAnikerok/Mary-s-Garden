extends Node2D

@export var res: Resource

@onready var sprite: Sprite2D = $Sprite2D

func  _ready():
	if res != null:
		sprite.texture = res.texture
	
