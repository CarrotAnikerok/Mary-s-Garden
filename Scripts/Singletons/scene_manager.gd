extends Node

var current_scene = null

#save
var save_path = "res://SAVES/game_save.tres"
var plants_data: Array[SavedData]

signal changed_scene()
signal loaded_world()
signal exit()

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(-1)
	load_game()
	
	
func goto_scene(path):
	changed_scene.emit()
	_deferred_goto_scene.call_deferred(path)
	
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path) as PackedScene
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	
func save_game():
	#создаю сохранение
	print("СОХРАНЯЮ ИГРУ")
	var saved_game: SavedGame = SavedGame.new()
	var saved_global_data: Array[SavedData] = []
	var saved_handbook_data: Array[SavedData] = []
	get_tree().call_group("global_world", "on_save_game", saved_global_data)
	get_tree().call_group("handbook_info", "on_save_game", saved_handbook_data)
	saved_game.global_world = saved_global_data
	saved_game.notes = saved_handbook_data
	
	saved_game.plant_room = plants_data
		
	ResourceSaver.save(saved_game, save_path)
	
	
func load_game():
	#нахожу сохранение
	print("ЗАГРУЖАЮ ИГРЫ ИГРУ")
	var saved_game:SavedGame = load(save_path)
	#загружаю глобальное сохранение
	if saved_game.global_world.size() != 0:
		get_tree().call_group("global_world", "on_load_game", saved_game.global_world[0])
	if saved_game.notes.size() != 0:
		get_tree().call_group("handbook_info", "on_load_game", saved_game.notes[0])
		
	plants_data = saved_game.plant_room
			
			
func save_plants():
	print_debug("СОХРАНЯЮ РАСТЕНИЯ")
	var saved_plant_data: Array[SavedData] = []
	get_tree().call_group("plant_room_events", "on_save_game", saved_plant_data)
	plants_data = saved_plant_data
	
	
func load_plants():
	print("ЗАГРУЖАЮ РАСТЕНИЯ")
	if plants_data.size() != 0:
		get_tree().call_group("plant_room_events", "on_before_load_game")
		for item in plants_data:
			prints("PlantsLoading")
			var scene = load(item.scene_path) as PackedScene
			var restored_node = scene.instantiate()
			var parent = get_node(item.parent_path)
			parent.add_child(restored_node)
			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)
				
				
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		exit.emit()
		save_game()
	
