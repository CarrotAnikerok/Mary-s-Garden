extends Control

@onready var paper = %Paper
@onready var paper1 = paper.get_child(0) as RichTextLabel
@onready var paper2 = paper.get_child(1) as RichTextLabel

@export var title_color: Color

var pages: Array[Vector2]
var page_number: int = 0

func _ready():
	#делает странные вещи
	GlobalTimer.changed_phase.connect(add_notes_from_hb)
	add_notes_from_hb()
	update_page_count()
	
	#check_for_override.call_deferred()
	#add_text("hiiii")
	#testing.connect("text_worked", Callable(self, "add_text").bind("hello!"))
	#testing.text_worked.connect(add_text)
	
	
#в комнате растений должен быть класс справочника, который сохраняет и отдает инфу
#но между сценами в принципе должна быть штука, которая сохраняет инфу. 
#<БОЛЕЕ ТОГО, фаза ведь может смениться и не только в комнате! то есть доступ 
#и обновлении к инфе о растении, справочнике, фазах должно быть постоянным.

		
func add_notes_from_hb():
	paper1.text = ""
	paper2.text = ""
	var first_index = -1
	var last_index = -1
	var i = 0
	page_number = 0
	pages.clear()
	for note in HandbookInfo.notes:
		if !check_capacity(paper2):
			first_index = last_index + 1
			last_index = i
			add_page(first_index, last_index)
		i += 1
		if note.type == "phase_change":
			add_title(note)
		else:
			add_text(note)
	toggle_buttons()
		
		
func add_text(note: Dictionary):
	var text = note.description
	if check_capacity(paper1):
		if paper1.text == "":
			paper1.text += text
		paper1.text += "\n" + text
	elif check_capacity(paper2):
		if paper2.text == "":
			paper2.text += text
		paper2.text += "\n" + text
	else:
		push_error("All papers are full")
		
		
func add_title(note: Dictionary):
	var text = note.title
	if check_capacity(paper1):
		if paper1.text == "":
			paper1.text += "[center][color=#b07450]" + text + "[/color][/center]"
		else: 
			paper1.text += "\n" + "[center][color=#b07450]" + text + "[/color][/center]"
	elif check_capacity(paper2):
		if paper2.text == "":
			paper2.text += "[center][color=#b07450]" + text + "[/color][/center]"
		else: 
			paper2.text += "\n" + "[center][color=b07450]" + text + "[/color][/center]"
	else:
		push_error("All papers are full even for title")


func _on_exit_button_pressed():
	queue_free()


func check_capacity(label: RichTextLabel):
	if label.get_content_height() + 65 >= paper.size.y:
		return false
	else:
		return true
	
	
func _on_next_button_pressed():
	if  page_number >= pages.size():
		push_error("UNIMPLEMENTED ERROR: It's the last page of handbook")
		return
		
	page_number += 1
	toggle_buttons()
	if page_number == pages.size():
		change_page(pages[page_number-1].y, HandbookInfo.notes.size())
	else:
		change_page(pages[page_number].x, pages[page_number].y)


func _on_prev_button_pressed():
	if page_number <= 0 or page_number > pages.size():
		push_error("UNIMPLEMENTED ERROR: It's the first page of handbook")
		return

	page_number -= 1
	toggle_buttons()
	change_page(pages[page_number].x, pages[page_number].y)


func update_page_count():
	$PageCounts/PageCount1.text = str(page_number * 2 + 1)
	$PageCounts/PageCount2.text = str(page_number * 2 + 2)
	
	
func change_page(from_line, to_line):
	update_page_count()
	paper1.text = ""
	paper2.text = ""
	for i in range(from_line, to_line):
		print("PRINTING LINES FROM " + str(pages[page_number-1].x,) + " TO " + str(pages[page_number-1].y))
		if HandbookInfo.notes[i].type == "phase_change":
			add_title(HandbookInfo.notes[i])
		else:
			add_text(HandbookInfo.notes[i])


func add_page(first_index, last_index):
	var vect = Vector2(first_index, last_index)
	pages.append(vect)
	page_number += 1
	update_page_count()
	paper1.text = ""
	paper2.text = ""
	
	
func toggle_buttons():
	if page_number == 0:
		$PrevButton.hide()
	else:
		$PrevButton.show()
	if page_number == pages.size():
		$NextButton.hide()
	else:
		$NextButton.show()
