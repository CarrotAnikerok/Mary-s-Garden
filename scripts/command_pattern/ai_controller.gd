class_name AiController
extends Node

@export var camera: MainCamera
@export var arin: NPC
@export var mary: Character
@export var scarlett: Character
@export var mark: Character
@export var kris: Character

@onready var characters = %Characters

var current_characters: Dictionary[String, Node2D]


var timer: SceneTreeTimer

const SCENARY_1 = preload("res://scenary/scenary_1.tres")
const SCENARY_2 = preload("res://scenary/scenary_2.tres")
@onready var bt_player = $BTPlayer


func _ready():
	pass
	#start_scenary(SCENARY_2)


func move_character_to(character: Character, target_pos: Vector2, delta: float, speed: float = 40):
	var direction = Vector2(
		target_pos.x - character.position.x,
		target_pos.y - character.position.y
	).normalized()
	
	character.animated_sprite.play("walk")
	sprite_flip(character, direction.x)
	character.position += direction * delta * speed


func sprite_flip(character, dir):
	character.animated_sprite.flip_h = dir < 0


func move_camera(move_to: float, speed: float):
	camera.under_ai = true
	var tween = create_tween()
	await tween.tween_property(camera, "position", Vector2(move_to, 108), speed)


func return_control():
	mary.set_controller(HumanController.new(mary))
	camera.under_ai = false


func take_control():
	mary.remove_controller()
	
	
func scenary_end():
	return_control()
	bt_player.blackboard.set_var("start_scenary", false)


func start_scenary(scenary: Resource):
	take_control()
	bt_player.behavior_tree = scenary
	bt_player.blackboard.set_var("start_scenary", true)


func _on_button_pressed():
	start_scenary(SCENARY_2)
