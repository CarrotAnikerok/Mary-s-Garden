class_name AloeVera
extends Plant

# Called when the node enters the scene tree for the first time.
func _ready():
	normalWaterAmount = 300
	actualWaterCoefficent = 0
	minWaterCoefficent = 0.2
	maxWaterCoefficent = 0.95

	
func waterPlant():
	normalWaterAmount += 50
	print(normalWaterAmount)
	print("Aloe was watered")
