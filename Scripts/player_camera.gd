extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#global_position.x = 160


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_parent().global_position.x < 160):
		global_position.x = 160
	if (get_parent().global_position.x > 320):
		global_position.x = 320
