extends CharacterBody2D

const tile_size: Vector2 = Vector2(48, 48)
@onready var spr = $Sprite2D
var sprite_node_pos_tween: Tween 
var facing_ray
var item_near = "none"
var disabled = false
var true_disabled = false
var instanced = false
var dir



func _physics_process(delta: float) -> void:
	if true_disabled:
		return
	if !disabled :
		if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
			
			if Input.is_action_pressed("ui_up"):
				facing_ray = $up
				dir = Vector2(0,-1)
			elif Input.is_action_pressed("ui_down"):
				facing_ray = $down
				dir = Vector2(0,1)
			elif Input.is_action_pressed("ui_left"):
				facing_ray = $left
				dir = Vector2(-1,0)
			elif Input.is_action_pressed("ui_right"):
				facing_ray = $right
				dir = Vector2(1,0)
			else:
				dir = Vector2(0,0)
			
			if facing_ray != null && dir != null:
				animation_manager(dir)
				if !facing_ray.is_colliding():
						_move(dir)
						item_near = "none"
				else:
					item_near = facing_ray.get_collider().name
					
		
	if Input.is_action_just_pressed("interact"):
		if TextManager.rs.visible:
			TextManager.rs.visible = false
		elif TextManager.hm.visible:
			TextManager.hm.visible = false
		elif TextManager.tb.visible :
			TextManager.close_text(item_near)
			item_near = "none"
			disabled = false
		elif item_near.contains("front_door"):
			get_parent().on_entered_done = false
			SystemManager.open_juggling(position)
		elif item_near.contains("back_door"):
			SystemManager.open_balcony()
		elif !item_near.contains("none")&&!item_near.contains("Wall"):
			print(item_near)
			disabled = true
			TextManager.display_text(item_near)
			
	if Input.is_action_just_pressed("back"):
		if TextManager.rs.visible:
			TextManager.rs.visible = false
		elif TextManager.hm.visible:
			TextManager.hm.visible = false
	

func animation_manager(dir):
	if dir.x > 0 && dir.y == 0:
		spr.frame = 2
	elif dir.x < 0 && dir.y == 0:
		spr.frame = 0
	elif dir.x == 0 && dir.y > 0:
		spr.frame = 1
	elif dir.x == 0 && dir.y < 0:
		spr.frame = 3


func _move(dir: Vector2):
	global_position += dir * tile_size
	$Sprite2D.global_position -= dir * tile_size
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.285).set_trans(Tween.TRANS_LINEAR)
