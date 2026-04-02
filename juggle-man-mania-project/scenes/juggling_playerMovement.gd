extends CharacterBody2D

@export var movement_speed : float = 500
var character_direction : Vector2

func _physics_process(delta):
	character_direction.x = Input.get_axis("move_left", "move_right")
	
	
