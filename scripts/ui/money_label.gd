extends Label

var game_wallet: GameWallet = GameWallet

func _ready():
	change_value()
	game_wallet.wallet_changed.connect(change_value)
	
	
func change_value():
	text = str(game_wallet.get_current_sum()) + "€"

	
