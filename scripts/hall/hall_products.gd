extends Node


var bouquets: Array[Bouquet]
var teas: Array[Tea]
var perfume: Array[Perfume]

signal bouquet_sold(bouquet_name)

func _ready():
	bouquets = PlantProductInfo.bouquets
	teas = PlantProductInfo.teas
	perfume = PlantProductInfo.perfume


func sell_bouquet(bouquet_name: String):
	for bouquet in bouquets:
		if bouquet_name == bouquet.product_name:
			bouquet.sell()
			bouquets.erase(bouquet)
			print("bouquet sold!")
			return
	push_warning("There is no such bouquet here!")



func _on_button_pressed():
	var bouquet_name = "aloe_bouquet"
	print(GameWallet.get_current_sum())
	sell_bouquet(bouquet_name)
	print(GameWallet.get_current_sum())
	bouquet_sold.emit(bouquet_name)
