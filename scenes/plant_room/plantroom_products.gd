extends Node

@export var bouquets: Dictionary[String, Resource]
@export var teas: Dictionary[String, Resource]
@export var parfumes: Dictionary[String, Resource]

@export var inventory: Dictionary[String, Resource]
@export var recipies: Dictionary[String, CraftingRecipe]


func _on_button_2_pressed():
	var recipie = recipies["aloe bouquet"]
	if recipie.can_craft():
		recipie.craft()
		print("Bouquets" + str(PlantProductInfo.bouquets))
		print("Inventory" + str(PlantProductInfo.inventory))


func _on_button_3_pressed():
	PlantProductInfo.add_ingridient(inventory["aloe_leaves"])
	print("aloe leaves was added")
	print(PlantProductInfo.inventory)
