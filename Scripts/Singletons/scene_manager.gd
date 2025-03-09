extends Node

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)
	
func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path) as PackedScene
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
