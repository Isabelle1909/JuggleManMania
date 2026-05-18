extends CharacterBody2D

var gravity = Vector2(0,7)
var mass = 0.25
var vi
var vf
var acceleration
var dis_x
var dis_y
var maxV = 2500

var VXE = 150
var VXP = 100
var VXL = 50

var last_accuracy = "none"

func _ready() -> void:
	velocity = Vector2(0,-100)

func add_gravity(time):
	if velocity.y < maxV:
		velocity.y += gravity.y/mass
	move_and_slide()

func remove_x_velocity():
	VXE = 0
	VXP = 0
	VXL = 0

func _physics_process(delta: float) -> void:
	add_gravity(delta)

func get_last_accuracy() -> String:
	return last_accuracy

func add_impulse(dir,title):
	print(title)
	
	if velocity.y >= gravity.y/mass:
		velocity.y = 0
	
	if title.contains("early"):
		last_accuracy = "early"
		velocity.y = -700
		if dir.contains("left"):
			velocity.x = VXE
			TextManager.show_juggling_feedback("early","left")
		elif dir.contains("right"):
			velocity.x = -VXE
			TextManager.show_juggling_feedback("early","right")
		
	elif title.contains("perfect"):
		last_accuracy = "perfect"
		velocity.y = -1000
		if dir.contains("left"):
			velocity.x = VXP
			TextManager.show_juggling_feedback("perfect","left")
		elif dir.contains("right"):
			velocity.x = -VXP
			TextManager.show_juggling_feedback("perfect","right")
		
	elif title.contains("late"):
		last_accuracy = "late"
		velocity.y = -700
		if dir.contains("left"):
			velocity.x = VXL
			TextManager.show_juggling_feedback("late","leftt")
		elif dir.contains("right"):
			velocity.x = -VXL
			TextManager.show_juggling_feedback("late","right")
	else:
		last_accuracy = "none"
	
	if abs(velocity.y) > abs(maxV):
		velocity.y = (velocity.y/velocity.y) * maxV
	
	
#make an add impulse for late/early/perfect
#get it triggered by the juggling
