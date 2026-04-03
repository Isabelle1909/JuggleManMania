extends CharacterBody2D

@export var movement_speed : float = 400
var character_direction : Vector2
var done = true
var score = 0

#keeps track of the balls currently hitable
var early_left_zone = []
var perfect_left_zone = []
var late_left_zone = []

var early_right_zone = []
var perfect_right_zone = []
var late_right_zone = []

#how much force the balls are hit up with depending on timing
var early_impulse = Vector2(0,-400)
var perfect_impulse = Vector2(0,-200)
var late_impulse = Vector2(0,-50)

#whether the ball is hit slighty one way or the other depending on hand
var left_impulse = Vector2(0,0)
var right_impulse = Vector2(0,0)

func _physics_process(delta):
	movement_and_sprites()
	
	if Input.is_action_just_pressed("interact"):
		remove_dupes(early_left_zone,perfect_left_zone,late_left_zone)
		left_check()
		print(score)


func left_check():
	
	print(early_left_zone)
	print(perfect_left_zone)
	print(late_left_zone)
	var imp = early_impulse + left_impulse
	check_zone(early_left_zone,imp)
	imp = perfect_impulse + left_impulse
	check_zone(perfect_left_zone,imp)
	imp = late_impulse + left_impulse
	check_zone(late_left_zone,imp)


func remove_dupes(A1,A2,A3):
	for i in range(A1.size()):
		if A2.has(A1[i]):
			A2.erase(A1[i])
		if A3.has(A1[i]):
			A3.erase(A1[i])
	for i in range(A2.size()):
		if A3.has(A2[i]):
			A3.erase(A2[i])

func check_zone(zone,imp):
	if zone.size() > 0:
		
		if imp.y < -400:
			imp.y = -400
		print(imp)
		for i in range(zone.size()):
			zone[i].apply_impulse(imp)
			score += 10
		
		



#left/right movement and button hit controls
func movement_and_sprites():
	character_direction.x = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("interact"):
		%sprite.animation = "hit_left"
		done = false
	if Input.is_action_just_pressed("back"):
		%sprite.animation = "hit_right"
		done = false
	if done:
		if character_direction :
			velocity = character_direction * movement_speed
			if %sprite.animation != "Walking": %sprite.animation = "Walking"
		else:
			velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
			if %sprite.animation != "Idle": %sprite.animation = "Idle"
		
	velocity = character_direction * movement_speed
	move_and_slide()


#signals

func _on_sprite_animation_finished() -> void:
	done = true
	%sprite.play("Idle")
	print("done")

#hit area signals
func _on_early_left_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		if !early_left_zone.has(body):
			early_left_zone.append(body)

func _on_early_left_body_exited(body: Node2D) -> void:
	if body.name.contains("ball"):
		if early_left_zone.has(body):
			early_left_zone.erase(body)

func _on_perfect_left_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		if !perfect_left_zone.has(body):
			perfect_left_zone.append(body)

func _on_perfect_left_body_exited(body: Node2D) -> void:
	if body.name.contains("ball"):
		if perfect_left_zone.has(body):
			perfect_left_zone.erase(body)

func _on_late_left_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		if !late_left_zone.has(body):
			late_left_zone.append(body)

func _on_late_left_body_exited(body: Node2D) -> void:
	if body.name.contains("ball"):
		if late_left_zone.has(body):
			late_left_zone.erase(body)
