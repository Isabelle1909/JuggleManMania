extends CharacterBody2D

const tile_size: Vector2 = Vector2(48, 48)
@onready var animated_sprite = $AnimatedSprite2D
@onready var camera = $Camera2D

@onready var footstep_player = $FootstepPlayer

var sprite_node_pos_tween: Tween 
var camera_node_pos_tween: Tween
var facing_ray
var item_near = "none"
var object_near

var speed = 160

var disabled = false
var true_disabled = false
var waiting_answer_door = false
var waiting_answer_bed = false

var instanced = false

var dir
var ani = "idle_"



func _ready() -> void:
		facing_ray = $down
		animation_manager()

func _physics_process(delta: float) -> void:
	if true_disabled:
		return
	if !disabled :
		dir = Vector2(0,0)
		ani = "idle_"
		if Input.is_action_pressed("ui_up"):
			facing_ray = $up
			dir.y += -1
			ani = "walk_"
		if Input.is_action_pressed("ui_down"):
			facing_ray = $down
			dir.y += 1
			ani = "walk_"
		if Input.is_action_pressed("ui_left"):
			facing_ray = $left
			dir.x += -1
			ani = "walk_"
		if Input.is_action_pressed("ui_right"):
			facing_ray = $right
			dir.x += 1
			ani = "walk_"
			#if footstep_player.playing:
				#footstep_player.stop()
			
		if facing_ray != null && dir != null:
			animation_manager()
			if dir != Vector2.ZERO:
				if !facing_ray.is_colliding():
					dir.normalized()
					_move(dir)
					item_near = "none"
							
				else:
					item_near = facing_ray.get_collider().name
					object_near = facing_ray.get_collider()
					
		
	interaction_manager()
	

func interaction_manager():
	if Input.is_action_just_pressed("interact"):
		
		#check that the correct things are visible/not
		if TextManager.rs.visible:
			TextManager.rs.visible = false
		elif TextManager.hm.visible:
			TextManager.hm.visible = false
		elif TextManager.tb.visible :
			TextManager.close_text(item_near,TextManager.tb)
			disabled = false
			
		#Special Interactables
		elif item_near.contains("wardrobe"):
			if SystemManager.time.contains("morning") && !SystemManager.in_costume:
				SystemManager.in_costume = true
			elif SystemManager.time.contains("evening") && SystemManager.in_costume:
				SystemManager.in_costume = false
			else:
				disabled = true
				TextManager.display_text(item_near)
				
		elif item_near.contains("bed"):
			if SystemManager.time.contains("evening") && SystemManager.in_costume:
				TextManager.display_cutscene_text("prompt_text","undress",null,null)
			elif SystemManager.time.contains("evening") && !SystemManager.in_costume:
				TextManager.question_text("do you want to go to bed")
				disabled = true
				waiting_answer_bed = true
			else:
				disabled = true
				TextManager.display_text(item_near)
		elif item_near.contains("practice_box"):
			SystemManager.open_juggling(position)
		#doors
		elif item_near.contains("front_door"):
			if SystemManager.time.contains("morning") && SystemManager.in_costume == true:
				TextManager.question_text("do you want to go to work now?")
				disabled = true
				waiting_answer_door = true
			elif SystemManager.time.contains("morning"):
				TextManager.display_cutscene_text("prompt_text","dress",null,null)
			elif SystemManager.time.contains("evening"):
				TextManager.display_cutscene_text("prompt_text","stay",null,null)
				
		elif item_near.contains("back_door"):
			SystemManager.go_balc = true
			
		elif item_near.contains("in_door"):
			SystemManager.leave_balc = true
			
		#General Interactables
		elif !item_near.contains("none")&&!item_near.contains("Wall"):
			print(item_near)
			disabled = true
			TextManager.display_text(item_near)
			
		
	if Input.is_action_just_pressed("back"):
		if TextManager.rs.visible:
			TextManager.rs.visible = false
		elif TextManager.hm.visible:
			TextManager.hm.visible = false



func animation_manager():
	var costume
	var face
	if SystemManager.in_costume:
		costume = "clown_"
	else:
		costume = "normal_"
	if facing_ray.name.contains("up"):
		face = "back"
	elif facing_ray.name.contains("down"):
		face = "front"
	elif facing_ray.name.contains("left"):
		face = "left"
	elif facing_ray.name.contains("right"):
		face = "right"
	
	var animation = str(costume,ani,face)
	animated_sprite.play(animation)



func _move(dir: Vector2):
	
	if footstep_player:
		footstep_player.play()
		get_tree().create_timer(0.285).timeout.connect(func():
			if footstep_player:
				footstep_player.stop()
		)
	
	velocity = speed * dir
	move_and_slide()
	
	
