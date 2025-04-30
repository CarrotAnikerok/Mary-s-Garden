extends Panel

var plant_inv: Array[Ingridient]
var slots: Array[Node]

@export var cell_group_name: String
@export var ingridient_type: Ingridient.Type
@export var leave_and_flowers: bool

@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene

#проблема с проблемой боэе

func  _ready():
	plant_inv = PlantProductInfo.inventory
	slots = $GridContainer.get_children()
	
	#update_inventory(cell_group_name, ingridient_type, leave_and_flowers)


func fill_inventory(fill_with: Ingridient.Type = Ingridient.Type.LEAVES):
	var count_i = 0
	for ingridient in plant_inv:
		if (count_i < slots.size()):
			if (leave_and_flowers):
				if (ingridient.type == Ingridient.Type.FLOWER or ingridient.type == Ingridient.Type.LEAVES):
					var ingridient_node_instance = ingridient_node.instantiate()
					ingridient_node_instance.ingridient_res = ingridient;
					ingridient_node_instance.cell_group = cell_group_name
					slots[count_i].add_child(ingridient_node_instance)
					ingridient_node_instance.global_position = slots[count_i].global_position
					count_i+=1
			elif (ingridient.type == fill_with):
				var ingridient_node_instance = ingridient_node.instantiate()
				ingridient_node_instance.ingridient_res = ingridient;
				ingridient_node_instance.cell_group = cell_group_name
				slots[count_i].add_child(ingridient_node_instance)
				ingridient_node_instance.global_position = slots[count_i].global_position
				count_i+=1


func clear_inventory():
	for slot in slots:
		while slot.get_child_count() != 0:
			slot.remove_child(slot.get_child(0))


func update_inventory(cell_group: String, type: Ingridient.Type, leaves_flowers: bool):
	print("Updating inventory! " + str(plant_inv))
	print("Slots! " + str(slots))
	for slot in slots:
		slot.remove_from_group(cell_group_name)
	clear_inventory()
		
	cell_group_name = cell_group
	ingridient_type = type
	leave_and_flowers = leaves_flowers
	
	for slot in slots:
		slot.add_to_group(cell_group_name)
		
	fill_inventory(type)




	#for slot in slots:
		#if (count_i < plant_inv.size()):
			#print(plant_inv[count_i])
			##print("Inv "+ str(plant_inv[count_i].type) + " fill width " + str(fill_with))
			#if (plant_inv[count_i].type == fill_with):
				#var ingridient_node_instance = ingridient_node.instantiate()
				#ingridient_node_instance.ingridient_res = plant_inv[count_i];
				#ingridient_node_instance.cell_group = cell_group_name
				#slot.add_child(ingridient_node_instance)
				#ingridient_node_instance.global_position = slot.global_position
			#count_i+=1
