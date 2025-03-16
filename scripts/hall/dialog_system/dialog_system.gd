extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var dialog_part: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false

@onready var background = $Background
@onready var text_label = $TextLabel
@onready var name_label = $NameLabel
@onready var mary_sprite = $MarySprite
@onready var guest_sprite = $GuestSprite

func _ready():
	background.visible = false
	mary_sprite.visible = false
	guest_sprite.visible = false
	scene_text = load_scene_text()
	SignulBus.connect("display_dialog", Callable(self, "on_display_dialog"))
	
func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	name_label.text = dialog_part["name"].duplicate()
	if (dialog_part["name"] == "Mary"):
		mary_sprite.visible = true
		guest_sprite.visible = false
	else:
		guest_sprite.visible = true
		mary_sprite.visible = false
	selected_text = dialog_part["text"].duplicate()
	text_label.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false

func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		dialog_part = scene_text[text_key].duplicate()
		show_text()
