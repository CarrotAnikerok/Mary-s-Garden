extends Control

enum Modes {BOUQUET, PERFUME, TEA, ESSENTIAL}

@onready var create_essential_mode = %CreateEssentialMode
#@onready var tea_mode = %TeaMode
#@onready var bouquet_mode = %BouquetMode
@onready var perfume_mode = %PerfumeMode

const CREATE_ESSENTIAL_MODE = preload("res://scenes/plant_workshop/modes/create_essential_mode.tscn")
const TEA_MODE = preload("res://scenes/plant_workshop/modes/tea_mode.tscn")
const PERFUME_MODE = preload("res://scenes/plant_workshop/modes/perfume_mode.tscn")
const BOUQUET_MODE = preload("res://scenes/plant_workshop/modes/bouquet_mode.tscn")

@onready var plant_inventary = %PlantInventary
@onready var ingridient_inventary = %IngridientInventary

@onready var modes_ind = $"../ModesInd"

@export var modes_pict: Dictionary[Modes, AtlasTexture]

var modes: Array[Control]

func _ready():
	modes = [perfume_mode, create_essential_mode];
	toggle_mode.call_deferred(Modes.BOUQUET)
	$"../ModeButtons/BouquetButton".grab_focus()



#плюс надо выплюнуть все растения
func toggle_mode(mode: Modes):
	for child in get_children():
		remove_child(child)
	for m in modes:
		m.visible = false
		for child in get_all_children(m):
			if child is Control:
				child.visible = false
	match mode:
		Modes.BOUQUET:
			var bouquet_mode_inst = BOUQUET_MODE.instantiate()
			add_child(bouquet_mode_inst)
			
			plant_inventary.update_inventory("leaves inventory", Ingridient.Type.LEAVES, false)
			ingridient_inventary.update_inventory("flower inventory", Ingridient.Type.FLOWER, false)
			
			modes_ind.texture = modes_pict[Modes.BOUQUET]
		Modes.PERFUME:
			var perfume_mode_inst = PERFUME_MODE.instantiate()
			add_child(perfume_mode_inst)

			ingridient_inventary.update_inventory("oil inventory", Ingridient.Type.OIL, false)
			plant_inventary.update_inventory("leaves inventory", Ingridient.Type.LEAVES, true)
			
			modes_ind.texture = modes_pict[Modes.PERFUME]
		Modes.TEA:
			var tea_mode_inst = TEA_MODE.instantiate()
			add_child(tea_mode_inst)
			
			ingridient_inventary.update_inventory("tea inventory", Ingridient.Type.TEA, false)
			plant_inventary.update_inventory("leaves inventory", Ingridient.Type.LEAVES, true)
			
			modes_ind.texture = modes_pict[Modes.TEA]
		Modes.ESSENTIAL:
			var essential_mode_inst = CREATE_ESSENTIAL_MODE.instantiate()
			add_child(essential_mode_inst)
			
			ingridient_inventary.update_inventory("oil inventory", Ingridient.Type.OIL, false)
			plant_inventary.update_inventory("leaves inventory", Ingridient.Type.LEAVES, true)
			
			modes_ind.texture = modes_pict[Modes.ESSENTIAL]
	print("filling inventary")



func _on_bouquet_button_pressed():
	toggle_mode(Modes.BOUQUET)


func _on_perfume_button_pressed():
	toggle_mode(Modes.PERFUME)


func _on_tea_button_pressed():
	toggle_mode(Modes.TEA)


func _on_create_essential_button_pressed():
	toggle_mode(Modes.ESSENTIAL)


func get_all_children(node: Node) -> Array:
	var nodes: Array = []
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			nodes.append_array(get_all_children(N))
		else:
			nodes.append(N)
	return nodes
	
	
##плюс надо выплюнуть все растения
#func toggle_mode(mode: Modes):
	#for child in container.get_children():
		#child.queue_free()
	#match mode:
		#Modes.BOUQUET:
			#var bouquet = bouquet_mode.instantiate()
			#container.add_child(bouquet)
		#Modes.PERFUME:
			#var perfume = perfume_mode.instantiate()
			#container.add_child(perfume)
		#Modes.TEA:
			#var tea = tea_mode.instantiate()
			#container.add_child(tea)
		#Modes.ESSENTIAL:
			#var essential = create_essential_mode.instantiate()
			#container.add_child(essential)
