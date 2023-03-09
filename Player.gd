extends Area2D

@export var speed = 400 #speed of the player in px/s
var screen_size # size of the screen

func _ready():
	screen_size = get_viewport_rect().size
