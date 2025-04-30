extends Node

var _money: int = 1000

signal wallet_changed

func get_current_sum():
	return _money


func make_money(sum: int):
	_money += sum
	wallet_changed.emit()
	return _money


func spend_money(sum:int):
	_money -= sum
	if _money < 0:
		_money = 0
	wallet_changed.emit()
	return _money
