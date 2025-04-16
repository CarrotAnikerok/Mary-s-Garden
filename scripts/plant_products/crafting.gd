extends Control

@onready var cell_1 = $Panel1
@onready var cell_2 = $Panel2
@onready var cell_3 = $Panel3
@onready var result = $Result

@onready var ingridients: Array[Ingridient] = [null, null, null]
var cells: Array[Control]
@export var crafting_recipies: Array[CraftingRecipe]

@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene

var current_recipe: CraftingRecipe

var showing_recipe: bool = false


func _ready():
	cells = [cell_1, cell_2, cell_3]
	cell_1.child_entered_tree.connect(update_ingridient)
	cell_2.child_entered_tree.connect(update_ingridient)
	cell_3.child_entered_tree.connect(update_ingridient)
	
	cell_1.child_exiting_tree.connect(update_ingridient)
	cell_2.child_exiting_tree.connect(update_ingridient)
	cell_3.child_exiting_tree.connect(update_ingridient)
	
	result.child_exiting_tree.connect(craft)
	


func update_ingridient(child):
	var i: int = 0
	var ingridient_sum: int = 0
	for cell in cells:
		if cell.get_child_count() != 0:
			ingridients[i] = cell.get_child(0).ingridient_res
			ingridient_sum +=1
			i+=1
		else:
			ingridient_sum +=0

	if ingridient_sum > 1:
		show_recipe()
	else: 
		destroy_recipe()

	print("Ingridients updated! Sum is = " + str(ingridient_sum))


func have_recipe() -> CraftingRecipe:
	for recipe in crafting_recipies:
		if recipe.can_craft_local(ingridients):
			print("have recipie!")
			return recipe
	print("dont have recipie :(")
	return null;
	

func show_recipe():
	current_recipe = have_recipe()
	if current_recipe != null and !showing_recipe:
		showing_recipe = true
		var ingridient_node_instance = ingridient_node.instantiate()
		ingridient_node_instance.ingridient_res = current_recipe.output
		result.add_child(ingridient_node_instance)
		ingridient_node_instance.global_position = result.global_position
	else:
		showing_recipe = false
		destroy_recipe()
		print("dont have recipie")


func craft(child):
	if showing_recipe:
		current_recipe.craft()
		print("crafted!")
		if cell_1.get_child_count() != 0:
			cell_1.get_child(0).queue_free()
			print(cell_1.get_children())
		if cell_2.get_child_count() != 0:
			cell_2.get_child(0).queue_free()
		if cell_3.get_child_count() != 0:
			cell_3.get_child(0).queue_free()
	else:
		print("dont have recipie")


func destroy_recipe():
	if result.get_child_count() != 0:
		result.get_child(0).queue_free()
