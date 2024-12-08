extends Node

func _ready():
	$PlantWindow.visible = false
	$Cactus.visible = false
	$Sprite2D.visible = false

func _on_aloe_pressed():
	#$PlantWindow.get_tree().root.remove_child(node_to_remove)
	#$PlantWindow.get_tree().root.add_child($AloeVera)
	$Sprite2D.visible = true
	$PlantWindow.visible = true
	$PlantWindow.active_plant = $SubViewport/AloeVera


func _on_cactus_pressed():
	$Sprite2D.visible = false
	$PlantWindow.visible = true
	$PlantWindow.active_plant = $Cactus
	
func on_button_pressed():
	$PlantWindow.active_plant.waterPlant()
	
	
	
