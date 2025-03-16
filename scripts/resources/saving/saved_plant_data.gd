class_name SavedPlantData
extends SavedData

@export var id: int
@export var plant_name: String
@export var normal_water_amount: int 
@export var actual_water_coefficent: float
@export var actual_light_amount: int
@export var actual_light_time: int
@export var actual_humidity: float
@export var actual_temperature: int
@export var plant_state: int
@export var is_alive := true
@export var light_on := false
@export var is_overpoured := false
@export var is_first_pour := true
@export var deadly_bad_for_too_long := false
@export var bad_parameters := [0, 0, 0, 0] #вода, свет, влажность, температура
@export var parent_path: String
