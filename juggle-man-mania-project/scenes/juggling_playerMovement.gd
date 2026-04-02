extends CharacterBody2D

@export var movement_speed : float = 300
var character_direction : Vector2
var done = true

#keeps track of the balls currently hitable
var early_left_zone = []
var perfect_left_zone = []
var late_left_zone = []

var early_right_zone = []
var perfect_right_zone = []
var late_right_zone = []

#how much force the balls are hit up with depending on timing
var early_impulse = Vector2(0,-400)
var perfect_impulse = Vector2(0,-350)
var late_impulse = Vector2(0,-300)

#whether the ball is hit slighty one way or the other depending on hand
var left_impulse = Vector2(10,0)
var right_impulse = Vector2(0,0)

func _physics_process(delta):
	movement_and_sprites()
	
	if Input.is_action_just_pressed("interact"):
		left_check()
		


func left_check():
	
	print(early_left_zone)
	print(perfect_left_zone)
	print(late_left_zone)
	
	if early_left_zone.size() > 0:
		
		var imp = early_impulse + left_impulse
		if imp.y < -400:
			imp.y = -400
		
		for i in range(early_left_zone.size()):
			early_left_zone[i].apply_impulse(imp)
			if perfect_left_zone.has(early_left_zone[i]):
				perfect_left_zone.erase(early_left_zone[i])
			elif late_left_zone.has(early_left_zone[i]):
				late_left_zone.erase(early_left_zone[i])
			
			early_left_zone.clear()
			
	if perfect_left_zone.size() > 0:
		
		var imp = perfect_impulse + left_impulse
		if imp.y < -400:
			imp.y = -400
		for i in range(perfect_left_zone.size()):
			perfect_left_zone[i].apply_impulse(imp)
			if late_left_zone.has(perfect_left_zone[i]):
				late_left_zone.erase(perfect_left_zone[i])
		
		perfect_left_zone.clear()
		
	if late_left_zone.size() > 0:
		
		var imp = late_impulse + left_impulse
		if imp.y < -400:
			imp.y = -400
		for i in range(late_left_zone.size()):
			late_left_zone[i].apply_impulse(imp)
		
		late_left_zone.clear()



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
