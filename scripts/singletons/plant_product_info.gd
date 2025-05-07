extends Node


var bouquets: Array[Bouquet]
var teas: Array[Tea]
var perfume: Array[Perfume]

var inventory: Array[Ingridient]

signal product_added

func _ready():
	var black_tea = load("res://custom_resources/other_ingridients/black_tea.tres")
	var viola_oil = load("res://custom_resources/other_ingridients/viola_oil.tres")
	const PELARGONIUM_FLOWERS = preload("res://custom_resources/plant_ingridients/pelargonium_flowers.tres")
	const LILIUM_FLOWERS = preload("res://custom_resources/plant_ingridients/lilium_flowers.tres")
	const BERGENIA_FLOWERS = preload("res://custom_resources/plant_ingridients/bergenia_flowers.tres")
	const BERGENIA_LEAVES = preload("res://custom_resources/plant_ingridients/bergenia_leaves.tres")
	const PHALEONOPSIS_FLOWERS = preload("res://custom_resources/plant_ingridients/phaleonopsis_flowers.tres")
	const VIOLA_FLOWERS = preload("res://custom_resources/plant_ingridients/viola_flowers.tres")
	add_ingridient(black_tea)
	add_ingridient(black_tea)
	add_ingridient(viola_oil)
	add_ingridient(viola_oil)
	add_ingridient(VIOLA_FLOWERS)
	add_ingridient(PHALEONOPSIS_FLOWERS)
	add_ingridient(BERGENIA_LEAVES)
	add_ingridient(BERGENIA_FLOWERS)
	add_ingridient(LILIUM_FLOWERS)
	add_ingridient(PELARGONIUM_FLOWERS)


func add_ingridient(ingridient: Ingridient):
	inventory.append(ingridient)


func remove_ingridient(ingridient: Ingridient):
	inventory.erase(ingridient)


func has_ingridient(ingridient: Ingridient):
	inventory.has(ingridient)


func add_product(plant_product: PlantProduct):
	if plant_product is Bouquet:
		bouquets.append(plant_product)
		product_added.emit()
	elif plant_product is Tea:
		teas.append(plant_product)
		product_added.emit()
	elif plant_product is Perfume:
		perfume.append(plant_product)
		product_added.emit()
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
