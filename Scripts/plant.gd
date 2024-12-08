class_name Plant
extends Node

var states = ["Perfect", "Good", "Neutral", "Bad", "Horrible", "Dead"]
var plant_state = 2
var phasesFromLastPour = 0
var alive = true
var lightOn = false
var howLongLightOn = 0

#individual Plant Parameters

var actualLightAmount
var minLightAmount
var maxLightAmount
var normalWaterAmount
var actualWaterCoefficent
var minWaterCoefficent
var maxWaterCoefficent
var actualHumidity
var maxHumidity
var minHumidity
var actualTemperature
var minTemperature
var maxTemperature
var phaseOfDay #im not sure if i need this

func change_state_logic():
	pass
func dry_logic():
	pass
func pour_logic():
	pass
func spray_logic():
	pass
	
#Abstract Methods

func pour(waterAmount):
	push_error("UNIMPLEMENTED ERROR: Plant.pour()")
func spray():
	push_error("UNIMPLEMENTED ERROR: Plant.spray()")
func change_state():
	push_error("UNIMPLEMENTED ERROR: Plant.change_state()")
func dry():
	push_error("UNIMPLEMENTED ERROR: Plant.dry()")

#Change of state

func change_state_down():
	pass
func change_state_up():
	pass
func change_state_to():
	pass
func change_light_amount():
	pass
func change_humidity():
	pass

func waterPlant():
	print("There is no plant to water")
	
func _on_button_pressed():
	waterPlant()
	
	
	
	
