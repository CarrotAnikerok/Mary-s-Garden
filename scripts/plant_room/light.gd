extends Node

@onready var rays = $rays
@onready var canvas = $CanvasModulate
var rays_arr: Array[Node]

var tween_rotate: Tween
var tween_canvas: Tween
var tween_light_color: Tween

func _ready():
	GlobalTimer.changed_phase.connect(change_light)
	GlobalTimer.changed_day.connect(start_new_day_light)
	rays_arr = rays.get_children()
	start_light()
	change_light()

func start_light():
	var x = 60
	for evray in rays_arr:
		var ray = evray as Light2D
		ray.position.x += x
		x += randf_range(20, 60)
		ray.scale.x = randf_range(0.05, 0.25)
		ray.set_height(randf_range(20, 70))
		ray.energy = randf_range(0.5, 3)
		create_moving_tween(ray)
		create_sizing_tween(ray)


func start_new_day_light():
	for evray in rays_arr:
		var ray = evray as Light2D
		ray.scale.x = randf_range(0.05, 0.25)
		create_moving_tween(ray)
		create_sizing_tween(ray)
		#что-то здесь вызывает ошибку
	start_morning_light()

func start_morning_light():
	Color(1.0, 0.706, 0.02)
	tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.497, 0.549, 0.72), 1)
	for evray in rays_arr:
		tween_light_color = create_tween()
		tween_rotate = create_tween()
		var ray = evray as Light2D
		tween_rotate.tween_property(ray, "rotation", -0.5, 1)
		tween_light_color.tween_property(ray, "color", Color(0.734, 0.638, 0.648), 1)
		
#можте лучше заставить лучи исчезнуть и снова появится?
func start_day_light():
	tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.78, 0.748, 0.538), 1)
	for evray in rays_arr:
		tween_rotate = create_tween()
		var ray = evray as Light2D
		tween_rotate.tween_property(ray, "rotation", 0.0, 1)
		
		
func start_evening_light():
	Color(0.281, 0.02, 1.0)
	tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.517, 0.308, 0.7), 1)
	for evray in rays_arr:
		tween_rotate = create_tween()
		tween_light_color = create_tween()
		var ray = evray as Light2D
		tween_light_color.tween_property(ray, "color", Color(Color(0.45, 0.679, 1.0)), 1)
		tween_rotate.tween_property(ray, "rotation", 0.5, 1)
		

func create_moving_tween(object):
	var tween = create_tween().set_loops()
	tween.tween_property(object, "position", Vector2(object.position.x + randf_range(-2, +2), 0), randf_range(2, 4))
	tween.tween_property(object, "position", Vector2(object.position.x + randf_range(-2, +2), 0), randf_range(2, 4))
	
	
func create_sizing_tween(object):
	var tween = create_tween().set_loops()
	tween.tween_property(object, "scale", Vector2(object.scale.x + 0.01, object.scale.y), randf_range(1, 2))
	tween.tween_property(object, "scale", Vector2(object.scale.x - 0.01, object.scale.y), randf_range(1, 2))

func change_light():
	match global.phase_of_day:
		0:
			start_morning_light()
		1:
			start_day_light()
		2:
			start_evening_light()

			
