extends Node

var style: DialogicStyle = preload("res://dialogs/styles/test_style.tres")


func _ready():
	style.prepare()
	SignulBus.display_dialog.connect(start_dialogic_dialog)


func start_dialogic_dialog(text_key):
	print_debug("DIALOGIC STARTED WITH " + text_key + " NAME")
	if Dialogic.current_timeline != null:
		push_warning("there is dialog going on, you can't start a new one")
		return
	
	Dialogic.start(text_key)
