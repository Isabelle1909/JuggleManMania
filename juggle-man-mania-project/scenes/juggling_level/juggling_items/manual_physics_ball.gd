extends CharacterBody2D

var gravity = Vector2(0,-9.0)
var mass = 1

func add_gravity():
	position += gravity * mass

func _physics_process(delta: float) -> void:
	add_gravity()
