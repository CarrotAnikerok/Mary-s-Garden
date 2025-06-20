extends BTAction

@export var dialog_name:String 
var is_dialog_over: bool = false

func _enter():
	SignulBus.emit_display_dialog(dialog_name)
	#ТУПОЕ НЕОДНОТОННОЕ ФУ
	Dialogic.timeline_ended.connect(success)
	
func _tick(delta):
	if is_dialog_over:
		return SUCCESS
	
	return RUNNING

func success():
	is_dialog_over = true
	
