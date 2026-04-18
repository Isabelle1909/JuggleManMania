extends CharacterBody2D

@export var movement_speed : float = 500

@onready var left_text = $left_feedback
@onready var right_text = $right_feedback

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
var early_impulse = Vector2(0,-200)
var perfect_impulse = Vector2(0,-100)
var late_impulse = Vector2(0,-50)

#whether the ball is hit slighty one way or the other depending on hand
var left_impulse = Vector2(50,0)
var right_impulse = Vector2(-50,0)

func _ready() -> void:
	left_text.visible = false
	right_text.visible = false

func _physics_process(delta):
	movement_and_sprites()
	
	if Input.is_action_just_pressed("interact"):
		remove_dupes(early_left_zone,perfect_left_zone,late_left_zone)
		check(early_left_zone,perfect_left_zone,late_left_zone,"left")
		print(score)
	if Input.is_action_just_pressed("back"):
		remove_dupes(early_right_zone,perfect_right_zone,late_right_zone)
		check(early_right_zone,perfect_right_zone,late_right_zone,"right")



func check(E,P,L,dir):
	print(E)
	print(P)
	print(L)
	check_zone(E,dir,"early")
	check_zone(P,dir,"perfect")
	check_zone(L,dir,"late")

func remove_dupes(E,P,L):
	for i in range(E.size()):
		if P.has(E[i]):
			P.erase(E[i])
		if L.has(E[i]):
			L.erase(E[i])
	for i in range(P.size()):
		if L.has(P[i]):
			L.erase(P[i])

func check_zone(zone,dir,title):
	
	if zone.size() > 0:
		
		for i in range(zone.size()):
			zone[i].add_impulse(dir,title)
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
	TextManager.hide_juggling_feedback()

#hit area signals
func _on_early_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !early_left_zone.has(body):
			early_left_zone.append(body)

func _on_early_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if early_left_zone.has(body):
			early_left_zone.erase(body)

func _on_perfect_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !perfect_left_zone.has(body):
			perfect_left_zone.append(body)

func _on_perfect_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if perfect_left_zone.has(body):
			perfect_left_zone.erase(body)

func _on_late_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !late_left_zone.has(body):
			late_left_zone.append(body)

func _on_late_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if late_left_zone.has(body):
			late_left_zone.erase(body)

func _on_early_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !early_right_zone.has(body):
			early_right_zone.append(body)

func _on_early_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if early_right_zone.has(body):
			early_right_zone.erase(body)

func _on_perfect_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !perfect_right_zone.has(body):
			perfect_right_zone.append(body)

func _on_perfect_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if perfect_right_zone.has(body):
			perfect_right_zone.erase(body)

func _on_late_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if !late_right_zone.has(body):
			late_right_zone.append(body)

func _on_late_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if late_right_zone.has(body):
			late_right_zone.erase(body)
