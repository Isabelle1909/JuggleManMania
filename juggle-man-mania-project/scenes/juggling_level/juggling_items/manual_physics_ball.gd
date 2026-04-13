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
	if Input.is_action_just_pressed("interact"):
		#add_impulse("left")
		pass
	elif Input.is_action_just_pressed("back"):
		#add_impulse("right")
		pass

func add_impulse(dir,title):
	print(title)
	if dir.contains("left"):
		velocity.x += 100
	elif dir.contains("right"):
		velocity.x += -100
	if velocity.y >= gravity.y/mass:
		velocity.y = 0
	
	if title.contains("early"):
		velocity.y += -1500
	elif title.contains("perfect"):
		velocity.y += -1000
	elif title.contains("late"):
		velocity.y += -500
	
#make an add impulse for late/early/perfect
#get it triggered by the juggling
