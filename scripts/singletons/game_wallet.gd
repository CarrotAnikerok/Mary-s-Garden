extends Node

var _money := 3000


func get_current_sum():
	return _money


func make_money(sum: int):
	_money += sum
	return _money


func spend_money(sum:int):
	_money -= sum
	if _money < 0:
		_money = 0
	return _money
