extends BTAction

@export var product_name: String 
@export var type: Product_Type

enum Product_Type {BOUQUET, PERFUME, TEA}

func _enter():
	if type ==Product_Type.BOUQUET:
		SignulBus.emit_signal("bouquet_needed", product_name)


func _tick(delta):
	return SUCCESS
