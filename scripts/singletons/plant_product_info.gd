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
	const EVENING_BEATY = preload("res://custom_resources/plant_produts/bouquets/evening_beaty.tres")
	const FIELD_MIRACLE = preload("res://custom_resources/plant_produts/bouquets/field_miracle.tres")
	const SMALL_BOUQUET = preload("res://custom_resources/plant_produts/bouquets/small_bouquet.tres")
	const BIG_BOUQUET = preload("res://custom_resources/plant_produts/bouquets/big_bouquet.tres")
	
	const FLOWER_BLAST = preload("res://custom_resources/plant_produts/perfume/flower_blast.tres")
	const ALOE_PERFUME = preload("res://custom_resources/plant_produts/perfume/aloe_perfume.tres")
	const VIOLA_PERFUME = preload("res://custom_resources/plant_produts/perfume/viola_perfume.tres")
	
	const ALOE_TEA = preload("res://custom_resources/plant_produts/tea/aloe_tea.tres")
	const SKY_DEW_TEA = preload("res://custom_resources/plant_produts/tea/sky_dew_tea.tres")
	const BERGENIA_TEA = preload("res://custom_resources/plant_produts/tea/bergenia_tea.tres")
	
	
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
	
	add_product(EVENING_BEATY)
	add_product(FIELD_MIRACLE)
	add_product(SMALL_BOUQUET)
	add_product(BIG_BOUQUET)
	add_product(SMALL_BOUQUET)
	add_product(BIG_BOUQUET)
	add_product(EVENING_BEATY)
	add_product(FIELD_MIRACLE)
	add_product(SMALL_BOUQUET)
	add_product(BIG_BOUQUET)
	add_product(SMALL_BOUQUET)
	add_product(BIG_BOUQUET)
	add_product(BIG_BOUQUET)
	
	add_product(FLOWER_BLAST)
	add_product(ALOE_PERFUME)
	add_product(VIOLA_PERFUME)
	add_product(ALOE_PERFUME)
	add_product(VIOLA_PERFUME)
	
	add_product(ALOE_TEA)
	add_product(SKY_DEW_TEA)
	add_product(BERGENIA_TEA)
	add_product(ALOE_TEA)
	add_product(SKY_DEW_TEA)


func add_ingridient(ingridient: Ingridient):
	inventory.append(ingridient)


func remove_ingridient(ingridient: Ingridient):
	inventory.erase(ingridient)


func has_ingridient(ingridient: Ingridient):
	inventory.has(ingridient)


func get_bouquet_by_name(product_name: String) -> Bouquet:
	for bouquet in bouquets:
		if bouquet.product_name == product_name:
			#print(bouquet.product_name)
			return bouquet
	return null

		

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


func sell_product(plant_product: PlantProduct):
	if plant_product is Bouquet:
		plant_product.sell()
		bouquets.erase(plant_product)
	elif plant_product is Tea:
		plant_product.sell()
		teas.erase(plant_product)
	elif plant_product is Perfume:
		plant_product.sell()
		perfume.erase(plant_product)
	else:
		push_warning("there is no such product to sell")
