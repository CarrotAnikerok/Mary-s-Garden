extends Control

@onready var active_plant = $"..".active_plant as Plant
@onready var watering_slider_menu = $"../SliderMenu"
@onready var slider = $"../SliderMenu/ColorRect2/WaterAmountHSlider"

signal worked_with_plant()

func _on_watering_can_button_pressed():
	slider.max_value = active_plant.normal_water_amount
	watering_slider_menu.visible = true
	
func _on_pour_button_pressed():
	active_plant.pour(slider.value)
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.name + " было полито на " + 
	str(slider.value) + "мл")
	worked_with_plant.emit()
	slider.value = 0
	watering_slider_menu.visible = false
	$"../PlantInfo/SoilHumidityInt".text = "%0.2f%%" % active_plant.actual_water_coefficent
	
func _on_spray_button_pressed():
	active_plant.spray();
	$"../PlantInfo/HumidityInt".text = "%0.2f%%" % active_plant.actual_humidity
	HandbookInfo.add_note("plant_action", active_plant.plant_name, active_plant.name + " было опрыснуто")
	worked_with_plant.emit()
	
func _on_light_button_pressed():
	active_plant.switch_light(3000)
	$"../PlantInfo/LightInt".text = str(active_plant.actual_light_amount)
