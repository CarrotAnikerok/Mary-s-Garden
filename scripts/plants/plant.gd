class_name Plant
extends Node2D

@export var public_name: String
@export var acceptable_stats: AcceptableStats
@export var perfect_stats: PerfectStats
#var states = ["Perfect", "Good", "Neutral", "Bad", "Horrible", "Dead"]
@export var plant_states: Array[PackedScene]
@export var plant_tools: Plant_Tools
@export var plant_ingridient_leaves: Ingridient
@export var plant_ingridient_flower: Ingridient 



var plant_window = load("res://scenes/plant_room/plant_window.tscn")
var plant_saves = load("res://custom_resources/plant_saves.tres") as SavedGame


#environment parameters
var base_light_amount: int
var base_humidity: float
var base_temperature: int


#not changing individual plant parameters
var plant_name: String
var plant_id := -1
var normal_water_amount: int
var dry_amount: float


#changing individual plant parameteres
var actual_light_amount: int
var actual_light_time: float #in hours
var actual_water_coefficent: float
var actual_humidity: float
var actual_temperature: int


#plant parameters to save
var is_alive = true
var light_on = false
var ground_timer: Timer
var ground_check := 0
var is_overpoured = false
var is_first_pour = true
var deadly_bad_for_too_long = false
var plant_state = 2
var bad_parameters = [0, 0, 0, 0] #вода, свет, влажность, температура
var can_give_flowers: bool = false
var can_give_leaves: bool = false


#acceptable Plant Parameters
@onready var acceptable_light_amount: Vector2 = acceptable_stats.acceptable_light_amount
@onready var acceptable_light_time: Vector2 = acceptable_stats.acceptable_light_time
@onready var acceptable_water_coefficent: Vector2 = acceptable_stats.acceptable_water_coefficent
@onready var acceptable_humidity: Vector2 = acceptable_stats.acceptable_humidity
@onready var acceptable_temperature: Vector2 = acceptable_stats.acceptable_temperature


#Perfect Plant Parameters
@onready var perfect_light_amount: Vector2 = perfect_stats.perfect_light_amount
@onready var perfect_light_time: Vector2 = perfect_stats.perfect_light_time
@onready var perfect_water_coefficent: Vector2 = perfect_stats.perfect_water_coefficent
@onready var perfect_humidity: Vector2 = perfect_stats.perfect_humidity
@onready var perfect_temperature: Vector2 = perfect_stats.perfect_temperature


func _enter_tree():
	add_child(Timer.new())
	ground_timer = get_child(-1)
	#print("Ground timer! " + str(ground_timer))
	add_to_group("game_events", true)


func place_update():
	var prev_light = base_light_amount
	var prev_temp = base_temperature
	var prev_humidity = base_humidity
	if get_parent().is_in_group("high_sunlight"):
		base_light_amount = 3000
		base_temperature = 25
	else:
		base_light_amount = 1000
		base_temperature = 20

	if get_parent().is_in_group("humid"):
		base_humidity = 0.6
	else:
		base_humidity = 0.3
		
	actual_light_amount = actual_light_amount - prev_light + base_light_amount
	actual_humidity = actual_humidity - prev_humidity + change_humidity(0.1) 
	#наверное влажность должна по-другому рабоатть...
	actual_temperature = actual_temperature - prev_temp + base_temperature
		
	print(plant_name + "Updates! Light:" + str(base_light_amount) + " Humidity:" + str(base_humidity))


func update_phase_logic():
	change_light_time(global.TIME_OF_PERIOD)
	is_first_pour = true


func change_state_logic():
	var how_bad_is_it = 0
	if !(can_be_perfect_logic()):
		how_bad_is_it = is_water_bad() + is_humidity_bad() + is_temperature_bad() + is_light_bad() + bad_too_long()
	
	print("total bads is " + str(how_bad_is_it) + " for " + plant_name)
	
	#Deterioration
	for i in range(1,5):
		if (plant_state == i && how_bad_is_it >= i):
			change_state_down()
			print(plant_name + " goes down")
			break

	#Improvement 
	for i in range(4,1,-1):
		if (plant_state == i && how_bad_is_it < (i - 1)):
			change_state_up()
			print(plant_name + " goes up")
			break
	
	#чек на подачу материала. явно должен быть где-то еще
	if plant_state == 0 :
		can_give_flowers = true
		can_give_leaves = true
	if plant_state == 1:
		can_give_flowers = false
		can_give_leaves = true
	else:
		can_give_flowers = false
		can_give_flowers = false
			
	if can_be_perfect_logic() and how_bad_is_it == 0:
		change_state_up()
	elif (!(can_be_perfect_logic()) and plant_state == 0):
		change_state_down()


func can_be_perfect_logic(): 
	var can_become_perfect = false
	if !(plant_state == 1 or plant_state == 0):
		return can_become_perfect
	print("wat+coef " + plant_name + " " + str(actual_water_coefficent < perfect_water_coefficent[1]
			and actual_water_coefficent > perfect_water_coefficent[0]))
	print("humidity " + plant_name + " " + str(actual_humidity < perfect_humidity[1]
			and actual_humidity > perfect_humidity[0]))
	print("temperature " + plant_name + " " + str(actual_temperature < perfect_temperature[1]
			and actual_temperature > perfect_temperature[0]))
	print("light_amount " + plant_name + " " + str(actual_light_amount < perfect_light_amount[1] + 1
			and actual_light_amount >= perfect_light_amount[0]))
	print("i overpoured? " + plant_name + " " + str(!is_overpoured))
			
	can_become_perfect = (actual_water_coefficent < perfect_water_coefficent[1]
			and actual_water_coefficent > perfect_water_coefficent[0]) and (actual_humidity < perfect_humidity[1]
			and actual_humidity > perfect_humidity[0]) and (actual_temperature < perfect_temperature[1]
			and actual_temperature > perfect_temperature[0]) and (actual_light_amount < perfect_light_amount[1] + 1
			and actual_light_amount >= perfect_light_amount[0]) and !is_overpoured
	print("Can become perfect?? " + str(can_become_perfect))
	return can_become_perfect


func dry_logic(dry_amount_various: float):
	if (actual_water_coefficent - dry_amount_various > 0):
		actual_water_coefficent -= dry_amount_various
	else:
		actual_water_coefficent = 0


func pour_logic(water_amount: float):
	print(plant_name + " is first pour? " + str(is_first_pour))
	if is_first_pour and water_amount != 0 and actual_water_coefficent > acceptable_water_coefficent[1]:
		is_overpoured = true
		print(plant_name + " is overpored")
	if water_amount != 0:
		is_first_pour = false
	if (actual_water_coefficent + water_amount / normal_water_amount > 1.0):
		actual_water_coefficent = 1.0
	else:
		actual_water_coefficent += water_amount / normal_water_amount


func spray_logic(spray_amount: float): 
	if (actual_humidity + spray_amount) > 1:
		actual_humidity = 1
	else:
		actual_humidity = actual_humidity  + spray_amount


func switch_light_logic(light_amount: int):
	if light_on == true:
		light_on = false
		actual_light_amount -= light_amount;
		print("Light off. Light amount " + str(actual_light_amount))
	else:
		light_on = true
		actual_light_amount = base_light_amount + light_amount;
		print("Light on! Light amount " + str(actual_light_amount))


func check_ground(time: float):
	ground_timer.one_shot = true
	if ground_timer.time_left == 0:
		ground_timer.start(time)
	else:
		ground_timer.stop()



#я думаю свет количество часов света в итоге будет отсчитываться не от фазы,
#а от настоящего времени. и это будет единственный такой параметр.
#but for now lets keep it simple
#Abstract Methods


func pour(_water_amount: float):
	push_error("UNIMPLEMENTED ERROR: Plant.pour()")
func spray():
	push_error("UNIMPLEMENTED ERROR: Plant.spray()")
func change_state():
	push_error("UNIMPLEMENTED ERROR: Plant.change_state()")
func switch_light(_lamp_power: int):
	push_error("UNIMPLEMENTED ERROR: Plant.switch_light()")
func dry():
	push_error("UNIMPLEMENTED ERROR: Plant.dry()")

#Change of state
func change_state_down():
	if (plant_state == 5):
		is_alive = false
		print(plant_name + " is already dead, it cant be any worse. IsAlive?" + str(is_alive))
	else:
		plant_state = plant_state + 1


func change_state_up():
	if (is_alive):
		if (plant_state == 0):
			print(plant_name + " is already perfect!")
		else:
			plant_state = plant_state - 1
	else:
		print(plant_name + " is already dead!")


func change_state_to(change_to: int):
	if (is_alive):
		plant_state = change_to
	else:
		print(plant_name + " is already dead! you cant revive it")


func change_light_amount():
	pass


#для растений в одной арее должна быть одна и так жа влажность? 
#или позволить отклонения?


func change_humidity(random_range: float):
	actual_humidity = base_humidity + randf_range(-random_range, random_range)
	if actual_humidity >= 1:
		actual_humidity = 1
	return actual_humidity


#bad checks
func is_water_bad():
	var bad_count = 0 
	if actual_water_coefficent < acceptable_water_coefficent[0]:
		bad_count += 1
		print("water bad for " + plant_name)
		HandbookInfo.add_note("plant_after", plant_name, public_name + " походу засыхает.")
		bad_parameters[0] += 1
	elif is_overpoured:
		bad_count += 1
		HandbookInfo.add_note("plant_after", plant_name, public_name + " выглядит залитым.")
		is_overpoured = false
		bad_parameters[0] += 1
	if bad_count == 0:
		bad_parameters[0] = 0
	return bad_count


func is_humidity_bad():
	var bad_count = 0
	if (
			actual_humidity > acceptable_humidity[1]
			or actual_humidity < acceptable_humidity[0]
	):
		bad_count += 1
		HandbookInfo.add_note("plant_after", plant_name, public_name + " чувствует себя некомфортно в этой влажности")
		print("humidity bad for " + plant_name)
		print(actual_humidity)
	bad_parameters[2] += bad_count
	if bad_count == 0:
		bad_parameters[2] = 0
	return bad_count


func is_temperature_bad():
	var bad_count = 0
	if (
			actual_temperature > acceptable_temperature[1]
			or actual_temperature < acceptable_temperature[0]
	):
		bad_count += 1
		print("temperature bad for " + plant_name)
		HandbookInfo.add_note("plant_after", plant_name, public_name + " чувствет себя плохо из-за температуры.")
	bad_parameters[3] += bad_count
	if bad_count == 0:
		bad_parameters[3] = 0
	return bad_count


func is_light_bad():
	var bad_count = 0
	if (
			global.phase_of_day != 2
			and ((actual_light_amount > acceptable_light_amount[1]) 
			or (actual_light_amount < acceptable_light_amount[0]))
		):
		HandbookInfo.add_note("plant_after", plant_name, public_name + " неправильно освещается")
		bad_count += 1
		print("light bad for " + plant_name)
	if (
			global.phase_of_day == 2
			and ((actual_light_time > acceptable_light_time[1])
			or (actual_light_time < acceptable_light_time[0]))
		): #если новый день наступил, но в пред день свет горел неправильно
		bad_count += 1
		HandbookInfo.add_note("plant_after", plant_name, public_name + " требует ночного отдыха!")
		print("light time bad for " + plant_name + " " + str(global.phase_of_day))
	if (global.phase_of_day == 0):
		actual_light_time = 0 #лучшее ли это место для этого? лучше придумать не могу
		print("CHECK 2 light time right now for " + plant_name + " is " + str(actual_light_time) )
	bad_parameters[1] += bad_count
	if bad_count == 0:
		bad_parameters[1] = 0
	return bad_count
	
#ночью свет должен быть МЕНЬШЕ определенного значения, меньше 1000 например. отдельная проверка на ночь
		#больше проверок богу проверок
		#бля почему то проверка все равно ночью делается, надо разобраться...
		
func change_light_time(light_time_on: float):
	if actual_light_amount >= acceptable_light_amount[0]:
		actual_light_time += light_time_on 
	print("LIGHT TIMER right now for " + plant_name + " is " + str(actual_light_time))
	print("LIGHT AMOUNT right now for " + plant_name + " is " + str(actual_light_amount) )

func bad_too_long():
	var bad_count = 0
	
	print("Bad parameters %s", bad_parameters)
	if ((bad_parameters[0] >= 5 or bad_parameters[1] >= 5)):
		bad_count = 4
	elif ((bad_parameters[0] == 4 or bad_parameters[1] == 4)):
		bad_count = 3
	elif (bad_parameters[0] == 3 or bad_parameters[1] == 3):
		bad_count = 2
	elif bad_parameters[0] == 2 or bad_parameters[1] == 2:
		bad_count = 1
	elif (bad_parameters[2] or bad_parameters[3]) and plant_state != 4:
		bad_count += 1
	
	return bad_count;


#ui and saving
func show_plant_menu():
	var plantwindow_instance = plant_window.instantiate()
	plantwindow_instance.active_plant = self
	plantwindow_instance.garden_slots = get_parent().get_parent()
	
	print_debug(owner)
	plantwindow_instance.garden_slots.owner.get_node("CanvasLayerUI").add_child(plantwindow_instance)
	#вот это я закауплил
	


func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedPlantData.new()
	pass_on_data(my_data)
	saved_data.append(my_data)
		
	ResourceSaver.save(plant_saves, "res://custom_resources/plant_saves.tres")


func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()


func on_load_game(saved_data: SavedData):
	take_data(saved_data)


func pass_on_data(stats:SavedData):
	stats.plant_name = plant_name
	stats.normal_water_amount = normal_water_amount
	stats.actual_water_coefficent = actual_water_coefficent
	stats.actual_light_amount = actual_light_amount
	stats.actual_light_time = actual_light_time
	stats.actual_humidity = actual_humidity
	stats.actual_temperature = actual_temperature
	stats.plant_state = plant_state
	stats.is_alive = is_alive
	stats.light_on = light_on
	stats.is_overpoured = is_overpoured
	stats.is_first_pour = is_first_pour
	stats.deadly_bad_for_too_long = deadly_bad_for_too_long
	stats.bad_parameters = bad_parameters
	stats.scene_path = scene_file_path
	stats.parent_path = get_parent().get_path()


func take_data(stats):
	plant_name = stats.plant_name
	normal_water_amount = stats.normal_water_amount
	actual_water_coefficent = stats.actual_water_coefficent
	actual_light_amount = stats.actual_light_amount
	actual_light_time = stats.actual_light_time
	actual_humidity = stats.actual_humidity
	actual_temperature = stats.actual_temperature
	plant_state = stats.plant_state
	is_alive = stats.is_alive
	light_on = stats.light_on
	is_overpoured = stats.is_overpoured
	is_first_pour = stats.is_first_pour
	deadly_bad_for_too_long = stats.deadly_bad_for_too_long
	bad_parameters = stats.bad_parameters

	
	
