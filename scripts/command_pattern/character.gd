class_name Character
extends Node2D

@export var speed = 120
@export var animated_sprite: AnimatedSprite2D

var _horizontal_input: float
var dialog = false


var _controller: CharacterController
@onready var _controller_container = $ControllerContainer


func set_controller(controller: CharacterController) -> void:
	for child in _controller_container.get_children():
		child.queue_free()
	
	_controller = controller
	_controller_container.add_child(_controller)


func remove_controller() -> void:
	for child in _controller_container.get_children():
		child.queue_free()


func _process(delta):
	move_character(delta)


func move_character(delta):
	var velocity = Vector2.ZERO
		
	velocity.x = _horizontal_input
	if velocity.length() > 0:
		velocity = velocity * speed
		
	position += velocity * delta


func move(value: float) -> void:
	_horizontal_input = value
	if value > 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif value < 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("stay")
	
