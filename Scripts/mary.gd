extends CharacterBody2D

@export var speed = 200
var screen_size
var dialog = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right") and !dialog:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		velocity.x += 1	
	elif Input.is_action_pressed("move_left") and !dialog:
		velocity.x -= 1
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("stay")
		
	
	if velocity.length() > 0:
		velocity = velocity * speed
		
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
