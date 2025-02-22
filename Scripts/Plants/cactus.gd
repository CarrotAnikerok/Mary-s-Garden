class_name Cactus
extends Plant

# Called when the node enters the scene tree for the first time.
func _ready():
	plant_name = "Cactus"
	place_update()
	normal_water_amount = 200
	actual_water_coefficent = 0
	acceptable_water_coefficent = Vector2(0.1, 1.00)
	actual_light_amount = base_light_amount
	acceptable_light_time = Vector2(3, 6)
	actual_light_time = 0 
	acceptable_light_amount = Vector2(2000, 4000)
	actual_humidity = base_humidity
	acceptable_humidity = Vector2(0.4, 0.7)
	actual_temperature = base_temperature
	acceptable_temperature = Vector2(15, 38)

func pour(water_amount: float):
	pour_logic(water_amount)

func dry():
	dry_logic(0.25)
	
func change_state():
	change_state_logic()
	
func spray():
	spray_logic(0.05)
	
func switch_light(lamp_power: int):
	switch_light_logic(lamp_power)
	
