extends TextureRect

signal text_worked(old, new)

func _process(delta):
	text_worked.emit("oldd")
