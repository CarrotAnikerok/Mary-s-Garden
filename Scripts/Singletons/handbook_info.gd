extends Node

var notes: Array[Dictionary]
var phases: Array = ["Утро1", "Утро2", "День1", "День2", "Вечер1", "Вечер2"]
var notes_dict: Array[Dictionary]
 
var prev_evening: String = "Конец прошлого дня"

func _ready():
	add_to_group("handbook_info")
	#json_notes.type = "plant_action"
	#json_notes.name = "Aloe Vera"
	#json_notes.description = "Water for 5 ml"
	#notes_dict.append(json_notes)
	#notes_dict.append(json_notes)
	#var json = JSON.stringify(notes_dict)
	#save_to_file(json)
	#load_from("res://SAVES/file.json")
	add_title(phases[global.phase_of_day])


func add_note(type, plant_name="", description=""):
	var dict = {
			"type": type,
			"name": plant_name,
			"description": description
		}
	notes.append(dict)
	
	
func add_title(title):
	var dict = {
			"type": "phase_change",
			"title": title,
		}
	notes.append(dict)
	
	
func change_phase_title():
	var i = global.phase_of_day + 1
	if (i == global.NUMBER_OF_PHASES):
		i = 0
		change_day()
	add_title(phases[i])
	
	
func change_day():
	var i = 0
	for note in notes:
		#то что тут строка, это оч плоъо
		if note.get("title") == phases[-1]:
			break
		else:
			i += 1
			
	for k in range(i):
		print_debug(notes.pop_front())
	notes[0].title = prev_evening
	

func save_to_file(content):
	var file = FileAccess.open("res://SAVES/file.json", FileAccess.WRITE)
	file.store_line(content)


func load_from(path):
	if not FileAccess.file_exists(path):
		return
		
	var file = FileAccess.open(path, FileAccess.READ)
	var json_string = file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	var data = json.data
	print(data[1].name)


func on_save_game(saved_data: Array[SavedData]):
	var my_data = SavedNotebookData.new()
	my_data.notes = notes
	saved_data.append(my_data)


func on_load_game(saved_data: SavedData):
	notes = saved_data.notes
