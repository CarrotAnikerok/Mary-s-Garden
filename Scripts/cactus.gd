class_name Cactus
extends Plant

# Called when the node enters the scene tree for the first time.
func _ready():
	normalWaterAmount = 200
	actualWaterCoefficent = 0
	minWaterCoefficent = 0.2
	maxWaterCoefficent = 0.95

	
func waterPlant():
	normalWaterAmount += 20
	print(normalWaterAmount)
	print("Cactus was watered")
