extends Panel

var bouquets_inv: Array[Bouquet]
var plant_inv: Array[Ingridient]
var slots: Array[Node]

@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene


func  _ready():
	bouquets_inv = PlantProductInfo.bouquets
	plant_inv = PlantProductInfo.inventory
	slots = $GridContainer.get_children()
	var timer := Timer.new()
	add_child(timer)
	timer.start(0.01)
	await timer.timeout
	fill_inventory()
	for slot in slots:
		print("Slot positions " + str(slot.global_position))
	

func fill_inventory():
	var count_i = 0
	for slot in slots:
		if (count_i < plant_inv.size()):
			var ingridient_node_instance = ingridient_node.instantiate()
			ingridient_node_instance.ingridient_res = plant_inv[count_i];
			slot.add_child(ingridient_node_instance)
			ingridient_node_instance.global_position = slot.global_position
			count_i+=1
