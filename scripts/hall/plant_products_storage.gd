extends Node2D

@onready var bouquets = %Bouquets
@onready var tea = %Tea
@onready var perfume = %Perfume


const PLANT_PRODUCT = preload("res://scenes/plant_workshop/plant_product.tscn")

func _ready():
	PlantProductInfo.product_added.connect(fill_all)
	SignulBus.bouquet_needed.connect(_on_products_bouquet_sold)
	fill_all()
	

func fill_all():
	fill_storage(PlantProductInfo.bouquets, bouquets)
	fill_storage(PlantProductInfo.perfume, perfume)
	fill_storage(PlantProductInfo.teas, tea)


func fill_storage(products, storage: Node2D):
	var slots = storage.get_children()
	var slot_count = 0;
	for product in products:
		if slot_count < slots.size():
			var product_node_instance = PLANT_PRODUCT.instantiate()
			product_node_instance.res = product
			
			slots[slot_count].add_child(product_node_instance)
			product_node_instance.global_position = slots[slot_count].global_position
			slot_count+=1


func clear_storage(storage: Node2D):
	var slots = storage.get_children()
	for slot in slots:
		while slot.get_child_count() != 0:
				slot.remove_child(slot.get_child(0))


func _on_products_bouquet_sold(bouquet_name):
	var bouquet = PlantProductInfo.get_bouquet_by_name(bouquet_name)
	print_debug("Bouquet is " + str(bouquet))
	if bouquet != null:
		clear_storage(bouquets)
		PlantProductInfo.sell_product(bouquet)
		fill_storage(PlantProductInfo.bouquets, bouquets)
