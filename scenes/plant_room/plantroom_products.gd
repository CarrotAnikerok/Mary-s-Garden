extends Node

@export var bouquets: Dictionary[String, Resource]
@export var teas: Dictionary[String, Resource]
@export var parfumes: Dictionary[String, Resource]

@export var inventory: Dictionary[String, Resource]
@export var recipies: Dictionary[String, CraftingRecipe]

@onready var plant_workshop = load("res://scenes/plant_room/plant_workshop/plant_workshop.tscn") as PackedScene
#@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene


func _on_button_2_pressed():
	var recipie = recipies["aloe bouquet"]
	if recipie.can_craft_global():
		recipie.craft()
		print("Bouquets" + str(PlantProductInfo.bouquets))
		print("Inventory" + str(PlantProductInfo.inventory))


func _on_button_3_pressed():
	PlantProductInfo.add_ingridient(inventory["aloe_leaves"])
	print("aloe leaves was added")
	print(PlantProductInfo.inventory)


func _on_button_4_pressed():
	var plant_work_inst = plant_workshop.instantiate()
	get_tree().get_root().add_child(plant_work_inst)
	#$"../../Button3".add_child(plant_work_inst)
	
