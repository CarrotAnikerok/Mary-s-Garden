extends Node

#поменять все сигналы на функции во всем коде, так безопаснее (не сделано)
#а еще мб сделать сигналы приватнее

signal display_dialog(text_key)

signal bouquet_needed(bouquet_name)
signal product_sold()
signal prodeuc_absent()

func emit_display_dialog(text_key: String) -> void:
	display_dialog.emit(text_key)


func emit_dailog_ended() -> void:
	Dialogic.timeline_ended.emit()
	#dialog_ended.emit()


func emit_bouquet_needed(bouquet_name: String) -> void:
	bouquet_needed.emit(bouquet_name)


func emit_product_sold() -> void:
	product_sold.emit()


func emit_product_absent() -> void:
	prodeuc_absent.emit()
