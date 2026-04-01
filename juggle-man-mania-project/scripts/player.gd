extends CharacterBody2D

const tile_size: Vector2 = Vector2(48, 48)
var sprite_node_pos_tween: Tween 
var facing_ray
var item_near

func _physics_process(delta: float) -> void:
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
	

func _move(dir: Vector2):
	global_position += dir * tile_size
	$Sprite2D.global_position -= dir * tile_size
	
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.285).set_trans(Tween.TRANS_LINEAR)
