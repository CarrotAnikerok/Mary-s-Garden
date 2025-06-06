extends Label

var game_wallet: GameWallet = GameWallet

func _ready():
	change_value()
	game_wallet.wallet_changed.connect(change_value)
	
	
func change_value():
	show()
	text = str(game_wallet.get_current_sum()) + "€"
	var tween = create_tween()
	tween.tween_interval(4)
	tween.tween_property(self, "theme_override_colors/font_color", Color(1.0, 0.567, 0.0, 0.0), 2)
	tween.tween_property(self, "visible", false, 1)
	tween.tween_property(self, "theme_override_colors/font_color", Color(1.0, 0.567, 0.0) , 1)
	
