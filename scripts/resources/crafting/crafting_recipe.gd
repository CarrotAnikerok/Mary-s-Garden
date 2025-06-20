class_name CraftingRecipe
extends Resource

@export var ingridients: Array[Ingridient]
@export var output: PlantProduct


func craft() -> void:
	for ingridient in ingridients:
		PlantProductInfo.remove_ingridient(ingridient)
		
	PlantProductInfo.add_product(output)
	
	
func craft_chaotic(chaotic_ingridients: Array[Ingridient]) -> void:
	for ingridient in chaotic_ingridients:
		PlantProductInfo.remove_ingridient(ingridient)

	PlantProductInfo.add_product(output)


func can_craft_global():
	var valid = true
	var inventory = PlantProductInfo.inventory.duplicate()
	for ingridient in ingridients:
		if inventory.has(ingridient):
			inventory.erase(ingridient)
		else:
			valid = false
			break
	
	return valid
	

func can_craft_local(elements: Array[Ingridient]):
	var valid = true
	var inventory = elements.duplicate()
	for ingridient in ingridients:
		if inventory.has(ingridient):
			print_debug(ingridient._to_string())
			inventory.erase(ingridient)
		else:
			valid = false
			break
	
	#проверка на то, что инвентарь и рецепт абсолютно совпадают
	if inventory.size() != 0:
		valid = false
	
	return valid
	
