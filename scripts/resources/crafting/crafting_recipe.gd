class_name CraftingRecipe
extends Resource

@export var ingridients: Array[Ingridient]
@export var output: PlantProduct


func craft() -> void:
	for ingridient in ingridients:
		PlantProductInfo.remove_ingridient(ingridient)
		
	PlantProductInfo.add_product(output)


func can_craft():
	var valid = true
	var inventory = PlantProductInfo.inventory.duplicate()
	for ingridient in ingridients:
		if inventory.has(ingridient):
			inventory.erase(ingridient)
		else:
			valid = false
			break
	
	return valid
