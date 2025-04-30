extends Control

@onready var crafting_cells = $CraftingCells/HBoxContainer

@onready var ingridients: Array[Ingridient]
@export var crafting_recipies: Array[CraftingRecipe]
@export var chaotic_recipies: Array[CraftingRecipe]

@onready var to_hall = $CraftingCells/HBoxContainer2/ToHall
@onready var result = $CraftingCells/HBoxContainer2/Result



var cells: Array[Node]

@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene

var current_recipe: CraftingRecipe

var showing_recipe: bool = false
var ingridient_sum: int = 0


func _ready():
	cells = crafting_cells.get_children() 
	for cell in cells:
		cell.child_entered_tree.connect(update_ingridient.bind("enter"))
		cell.child_exiting_tree.connect(update_ingridient.bind("exit"))
		cell.add_to_group("zone")
	
	to_hall.child_entered_tree.connect(craft)


func update_ingridient(child, regime: String):
	if regime == "enter":
		ingridients.append(child.ingridient_res)
		#ingridients[i] = child.ingridient_res
		ingridient_sum +=1
	elif regime == "exit":
		ingridients.erase(child.ingridient_res)
		ingridient_sum -=1
	else:
		ingridients.erase(child)
		ingridient_sum +=0

	print(str(ingridients) + " " + str(ingridient_sum))
	if ingridient_sum > 0:
		show_recipe()
	else: 
		destroy_recipe()

	print("Ingridients updated! Sum is = " + str(ingridient_sum))


func have_recipe() -> CraftingRecipe:
	print("STARTING RECIEPE")
	for recipe in crafting_recipies:
		if recipe.can_craft_local(ingridients):
			print("have recipie!")
			print("???")
			return recipe
	if ingridient_sum == 2:
		print("have chaotic recipe small")
		return chaotic_recipies[0]
	elif ingridient_sum == 3:
		print("have chaotic recipe big")
		return chaotic_recipies[1]
	else:
		print("dont have recipie :(")
		return null;
	

func show_recipe():
	current_recipe = have_recipe()
	if current_recipe != null and !showing_recipe:
		showing_recipe = true
		to_hall.visible = true
		var ingridient_node_instance = ingridient_node.instantiate()
		ingridient_node_instance.ingridient_res = current_recipe.output
		result.add_child(ingridient_node_instance)
		ingridient_node_instance.global_position = result.global_position
	elif current_recipe != null and showing_recipe:
		destroy_recipe()
		var ingridient_node_instance = ingridient_node.instantiate()
		ingridient_node_instance.ingridient_res = current_recipe.output
		result.add_child(ingridient_node_instance)
		ingridient_node_instance.global_position = result.global_position
	elif current_recipe == null:
		showing_recipe = false
		to_hall.visible = false
		destroy_recipe()
		print("dont have recipie 2")


func craft(child):
	if showing_recipe:
		if current_recipe.ingridients.size() == 0:
			current_recipe.craft_chaotic(ingridients)
		else:
			current_recipe.craft()
		print("crafted!")
		for cell in cells:
			if cell.get_child_count() != 0:
				cell.get_child(0).queue_free()

		if to_hall.get_child_count() != 0:
			to_hall.get_child(0).queue_free()
	else:
		print("dont have recipie 3")


func destroy_recipe():
	if result.get_child_count() != 0:
		result.get_child(0).queue_free()
