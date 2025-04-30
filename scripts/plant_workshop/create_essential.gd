extends Control

@export var essential_recipies: Array[EssentialRecipe]


@onready var input = %Input
@onready var output = %Output



@onready var timer: Timer = $Timer

@onready var progress_bar = $TextureRect/TextureProgressBar

@onready var ingridient_node = load("res://scenes/plant_workshop/ingridient.tscn") as PackedScene

var ingridient: Ingridient

func _ready():
	progress_bar.visible = false
	input.child_entered_tree.connect(update_input)
	#input.child_exiting_tree.connect(update_input)
	

func _process(delta):
	if timer.time_left > 0:
		progress_bar.value = 100 - (timer.time_left) * 20


func update_input(child):
	if input.get_child_count() != 0:
		ingridient = input.get_child(0).ingridient_res
	else:
		ingridient = null
		
	if ingridient != null:
		start_creating()


func have_recipe() -> EssentialRecipe:
	for recipe in essential_recipies:
		if recipe.can_create_local(ingridient):
			print("have essential recipie!")
			return recipe
	print("dont have essential recipie :(")
	return null;


func start_creating():
	var current_recipe = have_recipe()
	if current_recipe != null:
		timer.start()
		progress_bar.visible = true
		input.get_child(0).get_child(0).queue_free() #перестает быть движимым
		await timer.timeout
		progress_bar.visible = false
		
		var ingridient_node_instance = ingridient_node.instantiate()
		ingridient_node_instance.ingridient_res = current_recipe.oil
		ingridient_node_instance.cell_group = "oil inventory"
		#нужно обновить инвентарь для масел вообще..
		output.add_child(ingridient_node_instance)
		ingridient_node_instance.global_position = output.global_position
		
		current_recipe.create()
		
		if input.get_child_count() > 0:
			input.get_child(0).queue_free()
	else:
		print("dont have ssential reciepe")
