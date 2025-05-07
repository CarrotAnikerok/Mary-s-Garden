extends CanvasLayer

@export_file("*json") var scene_text_file: String
@export var mary_moods: Dictionary
@export var arin_moods: Dictionary
@export var scarlett_moods: Dictionary
@export var mark_moods: Dictionary
@export var chris_moods: Dictionary
@export var player: Character

var scene_text: Dictionary = {}
var dialog_part: Array = []
var dialog_block: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false
var sfx: AudioStream

var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.1
var text = ""


@onready var timer = $Timer
@onready var background = $TextBox
@onready var text_label = $TextBox/TextBoxPretty/TextLabel
@onready var name_label = $TextBox/NameLabel
@onready var text_box_pretty = $TextBox/TextBoxPretty
@onready var mary_sprite = $MarySprite
@onready var guest_sprite = $GuestSprite
@onready var audio_player = $AudioStreamPlayer
const speech_sound = preload("res://resources/audio/high_bleep.wav")

func _ready():
	background.visible = false #хочу поменять на вызывание схемы
	mary_sprite.visible = false
	guest_sprite.visible = false
	scene_text = load_scene_text()
	SignulBus.connect("display_dialog", Callable(self, "on_start_dialog"))


func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()


func show_text():
	name_label.text = dialog_block["name"]
	text_label.text = ""	
	text = selected_text.pop_front()
	change_sprite()
	change_mood()
	display_letter()


func next_line():
	if (text_label.text != text):
		text_label.text = text
		timer.stop()
		letter_index = 0
		return
	print(str(dialog_part.size()) + " and " + str(selected_text.size()))
	if selected_text.size() > 0:
		print("next_line is here", selected_text.size())
		show_text()
	elif dialog_part.size() > 0:
		print("next block is here?", dialog_block.size())
		dialog_block = dialog_part.pop_front()
		selected_text = dialog_block["text"].duplicate()
		show_text()
	else:
		finish()
	#if dialog_part.size() == 0 && selected_text.size() == 0:
		#finish()
	
func finish():
	var fin_timer =  get_tree().create_timer(0.1)
	text_label.text = ""
	background.visible = false
	name_label.visible = false
	mary_sprite.visible = false
	guest_sprite.visible = false
	player.dialog = false
	await fin_timer.timeout
	in_progress = false
	SignulBus.dialog_ended.emit()
	


func change_sprite():
	if (name_label.text == "Мэри"):
		mary_sprite.visible = true
		guest_sprite.visible = false
	else:
		guest_sprite.visible = true
		mary_sprite.visible = false


func change_mood():
	if (dialog_block.has("mood")):
		print(dialog_block["mood"])
		if (name_label.text == "Мэри"):
			mary_sprite.texture = mary_moods[dialog_block["mood"]]
			text_box_pretty.modulate = Color(0.9, 0.0, 0.42)
			print($TextBox/TextBoxPretty.modulate)
		elif (name_label.text == "Арин"):
			guest_sprite.texture = arin_moods[dialog_block["mood"]]
			text_box_pretty.modulate = Color(0.325, 0.802, 1.0)
			print($TextBox/TextBoxPretty.modulate)
		elif (name_label.text == "Скарлетт"):
			guest_sprite.texture = scarlett_moods[dialog_block["mood"]]
			text_box_pretty.modulate = Color(0.494, 0.003, 0.847)
		elif (name_label.text == "Марк"):
			guest_sprite.texture = mark_moods[dialog_block["mood"]]
		elif (name_label.text == "Крис"):
			guest_sprite.texture = chris_moods[dialog_block["mood"]]


func on_display_dialog(text_key):
	audio_player.stream = speech_sound
	if in_progress:
		next_line()
	else:
		player.dialog = true
		background.visible = true
		name_label.visible = true
		in_progress = true
		dialog_part = scene_text[text_key].duplicate()
		dialog_block = dialog_part.pop_front()
		selected_text = dialog_block["text"].duplicate()
		show_text()
		
func on_start_dialog(text_key):
	visible = true;
	audio_player.stream = speech_sound
	if !in_progress:
		player.dialog = true
		background.visible = true
		name_label.visible = true
		in_progress = true
		dialog_part = scene_text[text_key].duplicate()
		dialog_block = dialog_part.pop_front()
		selected_text = dialog_block["text"].duplicate()
		show_text()
	
		
func display_letter():
	text_label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		letter_index = 0
		return
		
	match text[letter_index]:
		"!", ",", "?", ".":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
			var new_audio_player = audio_player.duplicate()
			new_audio_player.pitch_scale += randf_range(-0.1, 0.1)
			if text[letter_index] in ["а", "и", "о", "ы", "у"]:
				new_audio_player.pitch_scale += 0.2
			get_tree().root.add_child(new_audio_player)
			new_audio_player.play()
			await new_audio_player.finished
			new_audio_player.queue_free()


func _on_timer_timeout():
	display_letter()


func _input(event):
	if event.is_action_pressed("ui_accept") and in_progress:
		next_line()
