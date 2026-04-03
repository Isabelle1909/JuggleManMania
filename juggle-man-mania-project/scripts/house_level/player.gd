extends CharacterBody2D

const tile_size: Vector2 = Vector2(48, 48)
@onready var spr = $Sprite2D
var sprite_node_pos_tween: Tween 
var facing_ray
var item_near = "none"
var disabled = false
var instanced = false




func _physics_process(delta: float) -> void:

	
	if !disabled :
		if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
			if Input.is_action_pressed("ui_up") and !$up.is_colliding():
				_move(Vector2(0, -1))
				facing_ray = $up
			elif Input.is_action_pressed("ui_down") and !$down.is_colliding():
				_move(Vector2(0, 1))
				facing_ray = $down
			elif Input.is_action_pressed("ui_left") and !$left.is_colliding():
				_move(Vector2(-1, 0))
				facing_ray = $left
			elif Input.is_action_pressed("ui_right") and !$right.is_colliding():
				facing_ray = $right
				_move(Vector2(1, 0))
		
	if facing_ray != null:
		if facing_ray.is_colliding():
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
		elif item_near.contains("door"):
			get_parent().on_entered_done = false
			SystemManager.open_juggling(position)
		elif !item_near.contains("none")&&!item_near.contains("Wall"):
			print(item_near)
			disabled = true
			TextManager.display_text(item_near)
			
	if Input.is_action_just_pressed("back"):
		if TextManager.rs.visible:
			TextManager.rs.visible = false
		elif TextManager.hm.visible:
			TextManager.hm.visible = false
	

func _move(dir: Vector2):
	global_position += dir * tile_size
	$Sprite2D.global_position -= dir * tile_size
	
	if dir.x > 0 && dir.y == 0:
		spr.frame = 2
	elif dir.x < 0 && dir.y == 0:
		spr.frame = 0
	elif dir.x == 0 && dir.y > 0:
		spr.frame = 1
	elif dir.x == 0 && dir.y < 0:
		spr.frame = 3
	else:
		spr.frame = 1
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.285).set_trans(Tween.TRANS_LINEAR)
