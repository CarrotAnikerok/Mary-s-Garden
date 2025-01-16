extends Node

func _ready():
	$PlantWindow.visible = false
	$Cactus.visible = false
	$AloeVera.visible = false

func _on_aloe_button_pressed():
	#$PlantWindow.get_tree().root.remove_child(node_to_remove)
	#$PlantWindow.get_tree().root.add_child($AloeVera)
	$AloeVera.visible = true
	$Cactus.visible = false
	$PlantWindow.visible = true
	$PlantWindow.active_plant = $AloeVera


func _on_cactus_button_pressed():
	$Cactus.visible = true
	$AloeVera.visible = false
	$PlantWindow.visible = true
	$PlantWindow.active_plant = $Cactus
	
#func on_button_pressed():
	#$PlantWindow.active_plant.waterPlant()
