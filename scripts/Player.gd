extends Area2D

signal hit

@export var speed = 400 #speed of the player in px/s
var screen_size # size of the screen

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "right"
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "left"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"


func _on_body_entered(body):
	hide()
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
