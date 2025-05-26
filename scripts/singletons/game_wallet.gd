extends Node

var _money: int = 1000
var _day_income: Array[int]

signal wallet_changed

func _ready():
	_day_income.resize(40)
	_day_income.fill(0)

func get_current_sum():
	return _money

func get_day_income():
	return _day_income[global.day_count]


func make_money(sum: int):
	_money += sum
	_day_income[global.day_count] += sum
	wallet_changed.emit()
	return _money


func spend_money(sum:int):
	_money -= sum
	if _money < 0:
		_money = 0
	wallet_changed.emit()
	return _money
