class_name Ingridient
extends Resource

enum Type {FLOWER, LEAVES, OIL, TEA}

@export var ingridietn_name: String
@export var texture: Texture
@export var type: Type

func _to_string() -> String:
	return ingridietn_name
