class_name KalanchoeBlossfeldiana
extends Plant

# Called when the node enters the scene tree for the first time.
func _ready():
	plant_name = "Kalanchoe Blossfeldiana"
	place_update()
	normal_water_amount = 300
	actual_water_coefficent = 0
	acceptable_water_coefficent = Vector2(0.3, 0.6) #ошибка в логике параметров воды. надо это передеалть
	perfect_water_coefficent = Vector2(0.1, 0.9)
	actual_light_amount = base_light_amount
	acceptable_light_time = Vector2(8, 14)
	perfect_light_time = Vector2(0, 16)
	actual_light_time = 0 
	acceptable_light_amount = Vector2(3000, 5000)
	perfect_light_amount = Vector2(2000, 8000)
	actual_humidity = base_humidity
	acceptable_humidity = Vector2(0.55, 0.85)
	perfect_humidity = Vector2(0.4, 1.0)
	actual_temperature = base_temperature
	acceptable_temperature = Vector2(15, 30)
	perfect_temperature = Vector2(15, 24)
	
	
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
	print("Kalanchoe was watered")

func changeToPerfect():
	pass
	
