class_name PlantDescription
extends Control


@onready var active_plant = $"../..".active_plant as Plant
@export_file("*json") var plant_description_file: String

@onready var label_name = $PlantName
@onready var label_description = $Description
@onready var tools = $"../ToolsButtons"

var pages: Array[Vector2]
var page_number: int = 0

var descriptions: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	descriptions = load_descriptions_file()
	hide_info_stuff()
	tools.worked_with_plant.connect(_on_info_button_pressed)
	GlobalTimer.changed_phase.connect(update_info)
	update_info()


func load_descriptions_file():
	if FileAccess.file_exists(plant_description_file):
		var file = FileAccess.open(plant_description_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text(true))
		return test_json_conv.get_data()
		

func _on_desc_button_pressed():
	change_check_to("desc_check")
	update_info()


func _on_info_button_pressed():
	change_check_to("info_check")
	update_info()


func _on_pract_desc_button_pressed():
	change_check_to("pract_check")
	update_info()


func _on_next_button_pressed():
	if  page_number >= pages.size():
		push_error("UNIMPLEMENTED ERROR: It's the last page of handbook")
		return
		
	page_number += 1
	update_page_count()
	toggle_moving_buttons()
	if page_number == pages.size():
		change_page(pages[page_number-1].y, HandbookInfo.notes.size())
	else:
		change_page(pages[page_number].x, pages[page_number].y)


func _on_prev_button_pressed():
	if page_number <= 0 or page_number > pages.size():
		push_error("UNIMPLEMENTED ERROR: It's the first page of handbook")
		return

	page_number -= 1
	update_page_count()
	toggle_moving_buttons()
	change_page(pages[page_number].x, pages[page_number].y)


func add_plant_notes():
	var first_index = -1
	var last_index = -1
	page_number = 0
	pages.clear()
	var i = 0
	for note in HandbookInfo.notes:
		if !check_capacity(label_description):
			first_index = last_index + 1
			last_index = i
			add_page(first_index, last_index)
		i += 1
		add_note(note)
	toggle_moving_buttons()


func add_page(first_index, last_index):
	var vect = Vector2(first_index, last_index)
	pages.append(vect)
	page_number += 1
	update_page_count()
	label_description.text = ""
	print("4 New content_height is " + str(label_description.get_content_height()))


func add_note(note):
	if note.type == "phase_change":
		if label_description.text == "":
			label_description.text += "[center][color=#bcd6a9]" + note.title + "[/color][/center]"
		else:
			label_description.text += "\n" + "[center][color=#bcd6a9]" + note.title + "[/color][/center]"
	elif note.name == active_plant.plant_name:
		if label_description.text == "":
			label_description.text += note.description
		else:
			label_description.text += "\n" + note.description
	

func change_page(from_line, to_line):
	label_description.text = ""
	for i in range(from_line, to_line):
		add_note(HandbookInfo.notes[i])


func check_capacity(paper):
	if paper.get_content_height() + 15 >= paper.size.y:
		return false
	else:
		return true


func update_info():
	var plant_name = active_plant.plant_name
	var plant_description = descriptions[plant_name].duplicate() as Array[String]
	label_name.text = plant_description[0]
	if global.desc_check:
		hide_info_stuff()
		label_description.text = plant_description[1] as String
	elif global.info_check:
		label_description.text = ""
		add_plant_notes()
	elif global.pract_check:
		label_description.text = plant_description[2]
	#print("pRINTIN UPDATE INFO")
	#print(label_description.get_visible_line_count())
	#print(label_description.get_total_character_count())
	#print(label_description.get_line_count())

		
#добавить перелистывание страниц обычных штучек
#func add_description(description: String):
	#var first_index = -1
	#var last_index = -1
	#page_number = 0
	#pages.clear()
	#if description.length() / 32 > label_description.get_visible_line_count():
		#label_description.get_visible_line_count() * 32
		



func change_check_to(state):
	match state:
		"info_check":
			global.desc_check = false
			global.info_check = true
			global.pract_check = false
		"desc_check":
			global.info_check = false
			global.desc_check = true
			global.pract_check = false
		"pract_check":
			global.pract_check = true
			global.info_check = false
			global.desc_check = false
		_:
			push_error("not right check")


func return_to_position(button: Control):
	var tween = get_tree().create_tween()
	tween.tween_property($DescButton, "position", Vector2(100, $DescButton.position.y), 0.2)
	tween.tween_property($PractDescButton, "position", Vector2(100, $PractDescButton.position.y), 0.2)
	tween.tween_property($InfoButton, "position", Vector2(100, $InfoButton.position.y), 0.2)
	tween.tween_property(button, "position", Vector2(95, button.position.y), 0.2)

func toggle_moving_buttons():
	if page_number == 0:
		$PrevButton.hide()
	else:
		$PrevButton.show()
	if page_number == pages.size():
		$NextButton.hide()
	else:
		$NextButton.show()


func update_page_count():
	if page_number > 0:
		$PageCount.show()
	$PageCount.text = str(page_number + 1)
	
	
func hide_info_stuff():
	$PageCount.hide()
	$PrevButton.hide()
	$NextButton.hide()
	
