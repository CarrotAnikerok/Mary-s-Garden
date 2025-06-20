class_name AloeVera
extends Plant

func _ready():
	plant_name = "Aloe Vera"
	place_update()
	normal_water_amount = 300
	actual_water_coefficent = 0
	actual_light_amount = base_light_amount
	actual_light_time = 0 
	actual_humidity = base_humidity
	actual_temperature = base_temperature
	
	
func pour(water_amount: float):
	pour_logic(water_amount)
	
func dry():
	dry_logic(0.2)

func spray():
	spray_logic(0.05)
	
func change_state():
	change_state_logic()
	update_phase_logic()
	
func switch_light(lamp_power: int):
	switch_light_logic(lamp_power)
	
func waterPlant():
	normal_water_amount += 50
	print(normal_water_amount)
	print("Aloe was watered")

func changeToPerfect():
	pass
	
	



#func _on_plant_pressed():
	#print("SAY PLANT")
	#var plantwindow_instance = plant_window.instantiate()
	#plantwindow_instance.active_plant = self
	#get_tree().get_root().add_child(plantwindow_instance)


#func _on_gui_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("I've been clicked D:")
