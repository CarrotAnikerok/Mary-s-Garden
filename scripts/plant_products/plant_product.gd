class_name PlantProduct
extends Resource

@export var product_name: String
@export var price: int
@export var texture: Texture2D


func create():
	pass


func sell():
	GameWallet.make_money(price)
	

func _to_string() -> String:
	return product_name
	
	
