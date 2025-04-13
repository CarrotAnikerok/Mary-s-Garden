extends Node


var bouquets: Array[Bouquet]
var teas: Array[Tea]
var perfume: Array[Perfume]

var inventory: Array[Ingridient]


func add_ingridient(ingridient: Ingridient):
	inventory.append(ingridient)


func remove_ingridient(ingridient: Ingridient):
	inventory.erase(ingridient)


func has_ingridient(ingridient: Ingridient):
	inventory.has(ingridient)


func add_product(plant_product: PlantProduct):
	if plant_product is Bouquet:
		bouquets.append(plant_product)
	elif plant_product is Tea:
		teas.append(plant_product)
	elif plant_product is Perfume:
		perfume.append(plant_product)
	else:
		push_warning("there is no such product to add")


func delete_product(plant_product: PlantProduct):
	if plant_product is Bouquet:
		bouquets.erase(plant_product)
	elif plant_product is Tea:
		teas.erase(plant_product)
	elif plant_product is Perfume:
		perfume.erase(plant_product)
	else:
		push_warning("there is no such product to delete")
