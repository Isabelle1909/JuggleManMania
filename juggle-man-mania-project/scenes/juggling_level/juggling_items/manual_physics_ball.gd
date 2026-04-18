extends CharacterBody2D

var gravity = Vector2(0,7)
var mass = 0.25
var vi
var vf
var acceleration
var dis_x
var dis_y
var maxV = 2500


func _ready() -> void:
	velocity = Vector2(0,-100)

func add_gravity(time):
	#dis_y = (velocity.y * time) + (0.5 * gravity.y * (time * time))
	#position.y += dis_y
	if velocity.y < maxV:
		velocity.y += gravity.y/mass
	move_and_slide()

func _physics_process(delta: float) -> void:
	add_gravity(delta)



func add_impulse(dir,title):
	print(title)
	
	if velocity.y >= gravity.y/mass:
		velocity.y = 0
	
	if title.contains("early"):
		velocity.y = -1100
		if dir.contains("left"):
			velocity.x = 150
			TextManager.show_juggling_feedback("early","left")
		elif dir.contains("right"):
			velocity.x = -150
			TextManager.show_juggling_feedback("early","right")
		
	elif title.contains("perfect"):
		velocity.y = -1000
		if dir.contains("left"):
			velocity.x = 100
			TextManager.show_juggling_feedback("perfect","left")
		elif dir.contains("right"):
			velocity.x = -100
			TextManager.show_juggling_feedback("perfect","right")
		
	elif title.contains("late"):
		velocity.y = -700
		if dir.contains("left"):
			velocity.x = 50
			TextManager.show_juggling_feedback("late","leftt")
		elif dir.contains("right"):
			velocity.x = -50
			TextManager.show_juggling_feedback("late","right")
	
	
	if abs(velocity.y) > abs(maxV):
		velocity.y = (velocity.y/velocity.y) * maxV
	
	
#make an add impulse for late/early/perfect
#get it triggered by the juggling
