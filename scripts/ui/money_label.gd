extends Label

var game_wallet: GameWallet = GameWallet

func _ready():
	change_value(game_wallet.get_current_sum())
	game_wallet.wallet_changed.connect(change_value.bind(game_wallet.get_current_sum()))
	
	
func change_value(money: int):
	text = str(money) + "€"
	
