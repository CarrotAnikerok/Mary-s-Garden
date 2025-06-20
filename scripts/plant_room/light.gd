extends Node

@onready var rays = $rays
@onready var canvas = $CanvasModulate
var rays_arr: Array[Node]


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
		ray.color = Color(0.734, 0.638, 0.648, 0)


func start_new_day_light():
	for evray in rays_arr:
		var ray = evray as Light2D
		ray.scale.x = randf_range(0.05, 0.25)
		create_moving_tween(ray)
		create_sizing_tween(ray)
		#что-то здесь вызывает ошибку / ???? what
	start_morning_light()

func start_morning_light():
	Color(1.0, 0.706, 0.02)
	var tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.497, 0.549, 0.72), 3)
	for evray in rays_arr:
		var tween = create_tween()
		var ray = evray as Light2D
		tween.tween_property(ray, "color", Color(0.734, 0.638, 0.648, 0), 0.7)
		tween.tween_property(ray, "rotation", -0.5, 0.3)
		tween.tween_property(ray, "color", Color(0.734, 0.638, 0.648), 1.5)


#можте лучше заставить лучи исчезнуть и снова появится?
func start_day_light():
	var tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.78, 0.748, 0.538), 3)
	for evray in rays_arr:
		var ray = evray as Light2D
		var tween = create_tween()
		tween.tween_property(ray, "color", Color(0.734, 0.638, 0.648, 0), 0.7)
		tween.tween_property(ray, "rotation", 0.0, 0.3)
		tween.tween_property(ray, "color", Color(0.734, 0.638, 0.648), 1.5)
		
		
func start_evening_light():
	Color(0.281, 0.02, 1.0)
	var tween_canvas = create_tween()
	tween_canvas.tween_property(canvas, "color", Color(0.517, 0.308, 0.7), 3)
	for evray in rays_arr:
		var tween = create_tween()
		var ray = evray as Light2D
		tween.tween_property(ray, "color", Color(Color(0.45, 0.679, 1.0, 0)), 0.7)
		tween.tween_property(ray, "rotation", 0.5, 0.3)
		tween.tween_property(ray, "color", Color(Color(0.45, 0.679, 1.0)), 1.5)
		

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
		2:
			start_day_light()
		4:
			start_evening_light()

			
