extends CharacterBody2D

var gravity = Vector2(0,7)
var mass = 0.25
var vi
var vf
var acceleration
var dis_x
var dis_y
var maxV = 2500
var disabled = false

var VXE = 250
var VXP = 100
var VXL = 50

var VYE = 750
var VYP = 1000
var VYL = 700

@onready var catch_sound = $CatchSound
var last_accuracy = "none"

var following = false
var dif

func _ready() -> void:
	velocity = Vector2(0,-100)

func add_gravity(time):
	if velocity.y < maxV:
		velocity.y += gravity.y/mass
	move_and_slide()

func reduce_speed(num):
	VYE = 750 * (num/7.0)
	VYP = 1000 * (num/7.0)
	VYL = 700 * (num/7.0)
	gravity = Vector2(0,4)

func remove_x_velocity():
	VXE = 0
	VXP = 0
	VXL = 0

func _physics_process(delta: float) -> void:
	
	add_gravity(delta)

func get_points() -> int:
	if last_accuracy.contains("early"):
		return 5
	elif last_accuracy.contains("perfect"):
		return 10
	elif last_accuracy.contains("late"):
		return 5
	else:
		return 0

func get_last_accuracy() -> String:
	return last_accuracy

func add_impulse(dir,title):
	print(title)
	
	if catch_sound:
		catch_sound.play(2.0)

		get_tree().create_timer(0.3).timeout.connect(func():
			if catch_sound:
				catch_sound.stop()
		)
	
	if velocity.y >= gravity.y/mass:
		velocity.y = 0
	
	if title.contains("early"):
		last_accuracy = "early"
		velocity.y = -VYE
		if dir.contains("left"):
			velocity.x = VXE
			TextManager.show_juggling_feedback("early","left")
		elif dir.contains("right"):
			velocity.x = -VXE
			TextManager.show_juggling_feedback("early","right")
		
	elif title.contains("perfect"):
		last_accuracy = "perfect"
		velocity.y = -VYP
		if dir.contains("left"):
			velocity.x = VXP
			TextManager.show_juggling_feedback("perfect","left")
		elif dir.contains("right"):
			velocity.x = -VXP
			TextManager.show_juggling_feedback("perfect","right")
		
	elif title.contains("late"):
		last_accuracy = "late"
		velocity.y = -VYL
		if dir.contains("left"):
			velocity.x = VXL
			TextManager.show_juggling_feedback("late","left")
		elif dir.contains("right"):
			velocity.x = -VXL
			TextManager.show_juggling_feedback("late","right")
	else:
		last_accuracy = "none"
	
	if abs(velocity.y) > abs(maxV):
		velocity.y = (velocity.y/velocity.y) * maxV
	
	
#make an add impulse for late/early/perfect
#get it triggered by the juggling
