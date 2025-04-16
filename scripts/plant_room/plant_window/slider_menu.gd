extends Control

@onready var active_plant = $"../..".active_plant as Plant
@onready var slider = $ColorRect2/WaterAmountHSlider
@onready var slider_label = $ColorRect2/SliderLabel


func _ready():
	visible = false
	
	
func _on_water_amount_h_slider_value_changed(value):
	slider_label.text = str(slider.value)


func _on_slider_bg_gui_input(_event):
	if Input.is_action_just_released("click"):
		visible = false
