extends TextureRect

@export var icons: Dictionary[String, AtlasTexture]

var tween: Tween


func _ready():
	visible = false
	#show_notice()


#потенциально в будущем эта штука будет находить и менять спрайтики в худшую сторону для любых из гостей постепенно
func change_notice_texture() -> void:
	texture = icons.get("guest_neutral")


func show_notice(scenary = null):
	visible = true
	position.y = 180
	tween = create_tween()
	tween.tween_property(self, "position:y", -30 , 1).as_relative()
	#tween.tween_property(self, "position:y", 3 , 1).as_relative()
	for i in 1000:
		if !tween:
			break
		tween.tween_property(self, "position:y", -3, 1).as_relative()
		tween.tween_property(self, "position:y", 3, 1).as_relative()


func hide_notice() -> void:
	tween.kill()
	var end_tween = create_tween()
	end_tween.tween_property(self, "position:y", 180, 1).set_ease(Tween.EASE_IN)
	end_tween.tween_callback(func(): texture = icons.get("guest_good") )
	#visible = false
	
