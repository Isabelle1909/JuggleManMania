extends CharacterBody2D

var gravity = Vector2(0,9.0)
var mass = 0.25
var vi
var vf
var acceleration
var dis_x
var dis_y
var maxV = 3000

func _ready() -> void:
	velocity = Vector2(0,-1000)

func add_gravity(time):
	dis_y = (velocity.y * time) + (0.5 * gravity.y * (time * time))
	#position.y += dis_y
	if velocity.y < maxV:
		velocity.y += gravity.y/mass
	move_and_slide()

func _physics_process(delta: float) -> void:
	add_gravity(delta)
	if Input.is_action_just_pressed("test input 1"):
		add_impulse()

func add_impulse():
	velocity.y += -2000
