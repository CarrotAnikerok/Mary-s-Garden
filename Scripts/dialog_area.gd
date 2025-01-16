extends Area2D

@export var text_key: String = ""
@export var dialog_player: CanvasLayer
var area_active: bool = false



func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		SignulBus.emit_signal("display_dialog", text_key)


func _on_area_entered(_area):
	print("area entered", text_key)
	area_active = true


func _on_area_exited(_area):
	print("area exited", text_key)
	area_active = false
