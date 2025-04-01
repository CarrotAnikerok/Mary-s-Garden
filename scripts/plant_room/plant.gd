class_name Plant
extends Node

@export var acceptable_stats: AcceptableStats
@export var perfect_stats: PerfectStats

#var states = ["Perfect", "Good", "Neutral", "Bad", "Horrible", "Dead"]
@export var plant_states: Array

var click_radius = 24
var plant_window = load("res://scenes/plant_room/plant_window.tscn")
var plant_saves = load("res://custom_resources/plant_saves.tres") as SavedGame

#environment parameters

var base_light_amount: int
var base_humidity: float
var base_temperature: int

#individual Plant Parameters

var plant_id := -1
var plant_name: String
var actual_light_amount: int
var actual_light_time: int #in hours
var normal_water_amount: int
var actual_water_coefficent: float
var actual_humidity: float
var actual_temperature: int

#Plant parameters to save

var is_alive = true
var light_on = false
var is_overpoured = false
var is_first_pour = true
var deadly_bad_for_too_long = false
var plant_state = 2
var bad_parameters = [0, 0, 0, 0] #вода, свет, влажность, температура

#Acceptable Plant Parameters

var acceptable_light_amount: Vector2
var acceptable_light_time: Vector2
var acceptable_water_coefficent: Vector2
var acceptable_humidity: Vector2
var acceptable_temperature: Vector2

#Perfect Plant Parameters

var perfect_light_amount: Vector2
var perfect_light_time: Vector2
var perfect_water_coefficent: Vector2
var perfect_humidity: Vector2
var perfect_temperature: Vector2

func _ready():
	acceptable_light_amount = acceptable_stats.acceptable_light_amount
	acceptable_light_time = acceptable_stats.acceptable_light_time
	acceptable_water_coefficent = acceptable_stats.acceptable_water_coefficent
	acceptable_humidity = acceptable_stats.acceptable_humidity
	acceptable_temperature = acceptable_stats.acceptable_temperature
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
		base_humidity = 0.7
	else:
		base_humidity = 0.4
		
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
			
	if can_be_perfect_logic() and how_bad_is_it == 0:
		change_state_up()
	elif (!(can_be_perfect_logic()) and plant_state == 0):
		change_state_down()
	
		
			
		
		
func can_be_perfect_logic(): 
	var can_become_perfect = false
	if (plant_state == 1 or plant_state == 0):
		print("wat+coef " + plant_name + " " + str(actual_water_coefficent < perfect_water_coefficent[1]
				and actual_water_coefficent > perfect_water_coefficent[0]))
		print("humidity " + plant_name + " " + str(actual_humidity < perfect_humidity[1]
				and actual_humidity > perfect_humidity[0]))
		print("temperature " + plant_name + " " + str(actual_temperature < perfect_temperature[1]
				and actual_temperature > perfect_temperature[0]))
		print("light_amount " + plant_name + " " + str(actual_light_amount < acceptable_light_amount[1]
				and actual_light_amount > acceptable_light_amount[0]))
		print("i overpoured? " + plant_name + " " + str(is_overpoured))
				
		can_become_perfect = (actual_water_coefficent < perfect_water_coefficent[1]
				and actual_water_coefficent > perfect_water_coefficent[0]) and (actual_humidity < perfect_humidity[1]
				and actual_humidity > perfect_humidity[0]) and (actual_temperature < perfect_temperature[1]
				and actual_temperature > perfect_temperature[0]) and (actual_light_amount < acceptable_light_amount[1]
				and actual_light_amount > acceptable_light_amount[0]) and !is_overpoured
		print("Can become perfect?? " + str(can_become_perfect))
	return can_become_perfect
	
	
func dry_logic(dry_amount: float):
	if (actual_water_coefficent - dry_amount > 0):
		actual_water_coefficent -= dry_amount
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
		
		
func change_light_time(light_time_on: int):
	actual_light_time += light_time_on;
	print("light time right now for " + plant_name + " is " + str(actual_light_time) )
		
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
	return actual_humidity

#bad checks

func is_water_bad():
	var bad_count = 0 
	if actual_water_coefficent < acceptable_water_coefficent[0]:
		bad_count += 1
		print("water bad for " + plant_name)
		HandbookInfo.add_note("plant_after", plant_name, plant_name + " походу засыхает.")
		bad_parameters[0] += 1
	elif is_overpoured:
		bad_count += 1
		HandbookInfo.add_note("plant_after", plant_name, plant_name + " выглядит залитым.")
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
		HandbookInfo.add_note("plant_after", plant_name, plant_name + " чувствует себя некомфортно в этой влажности")
		print("humidity bad for " + plant_name)
	bad_parameters[2] = bad_count
	return bad_count
	
	
func is_temperature_bad():
	var bad_count = 0
	if (
			actual_temperature > acceptable_temperature[1]
			or actual_temperature < acceptable_temperature[0]
	):
		bad_count += 1
		print("temperature bad for " + plant_name)
		HandbookInfo.add_note("plant_after", plant_name, plant_name + " чувствет себя плохо из-за температуры.")
	bad_parameters[3] = bad_count
	return bad_count


func is_light_bad():
	var bad_count = 0
	if (
			global.phase_of_day != 2
			and ((actual_light_amount > acceptable_light_amount[1]) 
			or (actual_light_amount < acceptable_light_amount[0]))
		):
		HandbookInfo.add_note("plant_after", plant_name, "что-то не так со светом для " + plant_name)
		bad_count += 1
		print("light bad for " + plant_name)
	if (
			global.phase_of_day == 2
			and ((actual_light_time > acceptable_light_time[1])
			or (actual_light_time < acceptable_light_time[0]))
		): #если новый день наступил, но в пред день свет горел неправильно
		bad_count += 1
		HandbookInfo.add_note("plant_after", plant_name, plant_name + " совсем не отдохнуло за ночь")
		print("light time bad for " + plant_name + " " + str(global.phase_of_day))
	if (global.phase_of_day == 0):
		actual_light_time = 0 #лучшее ли это место для этого? лучше придумать не могу
		print("CHECK 2 light time right now for " + plant_name + " is " + str(actual_light_time) )
	bad_parameters[1] = bad_count
	return bad_count
	
#ночью свет должен быть МЕНЬШЕ определенного значения, меньше 1000 например. отдельная проверка на ночь
		#больше проверок богу проверок
		#бля почему то проверка все равно ночью делается, надо разобраться...

	
func bad_too_long():
	var bad_count = 0
	if bad_parameters[0] or bad_parameters[1]:
		bad_count += 1
	elif (bad_parameters[2] or bad_parameters[3]) and plant_state != 4:
		bad_count += 1
	
	return bad_count;
		
	
func show_plant_menu():
	var plantwindow_instance = plant_window.instantiate()
	plantwindow_instance.active_plant = self
	get_tree().get_root().add_child(plantwindow_instance)
	
	
	
	
#func _input(event):
	#if event is InputEventMouseButton && $DraggableItem.draggable:
		#if (event.position - $Sprite2D.global_position).length() < click_radius:
			#if Input.is_action_just_released("click") and !global.is_dragging:
				#var plantwindow_instance = plant_window.instantiate()
				#plantwindow_instance.active_plant = self
				#get_tree().get_root().add_child(plantwindow_instance)
	
	
		#if (plant_state == 1 && how_bad_is_it >= 1):
		#change_state_down()
	#elif (plant_state == 2 && how_bad_is_it >= 2):
		#change_state_down()
	#elif (plant_state == 3 && how_bad_is_it >= 3):
		#change_state_down()
	#elif (plant_state == 4 && how_bad_is_it >= 4):
		#change_state_down()
	
	
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

	
	
