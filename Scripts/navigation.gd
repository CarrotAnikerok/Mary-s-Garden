extends Control

@onready var garden_slots = get_node("/root/PlantRoom/GardenSlots").get_children()
var sorted_plants: Array[Plant]
var active_plant
# Called when the node enters the scene tree for the first time.
func _ready():
	sort_plants()
	print(sorted_plants[0].plant_name)

	
func sort_plants():
	for slot in garden_slots:
		if slot.get_child_count() > 0:
			print(str(slot) + " found a child " + slot.get_child(0).name)
			sorted_plants.append(slot.get_child(0))


func _on_onward_button_pressed():
	var current_i = sorted_plants.find($"../..".active_plant)
	if current_i + 1 == sorted_plants.size():
		$"../..".active_plant = sorted_plants[0]
	else:
		$"../..".active_plant = sorted_plants[current_i + 1]
	$"../..".update_info()
	$"../PlantDescription".update_info()
	$"../ToolsButtons".update_info()
	


func _on_back_button_pressed():
	var current_i = sorted_plants.find($"../..".active_plant)
	if current_i  == 0:
		$"../..".active_plant = sorted_plants[sorted_plants.size() - 1]
	else:
		$"../..".active_plant = sorted_plants[current_i - 1]
	$"../..".update_info()
	$"../PlantDescription".update_info()
	$"../ToolsButtons".update_info()
