extends Node2D

@onready var score_display = $score_display/RichTextLabel
@onready var player = $juggling_player
@onready var juggling_items = $juggling_items
@onready var quit_panel = $Panel

var active_juggling_items = []
var score = 0
var timer = 10
var finish = false
var infinite = false

var ball = load("res://scenes/juggling_level/juggling_items/manual_physics_ball.tscn")

var done = false

func _ready() -> void:
	SystemManager.j_done = true
	timer = 10
	print("juggling")
	infinite = SystemManager.juggle_infinite
	if infinite:
		quit_panel.visible = true
	else:
		quit_panel.visible = false
		if SystemManager.day == 2:
			pass
		elif SystemManager.day == 3:
			pass
	
	TextManager.jfl = player.get_node("left_panel")
	TextManager.jfr = player.get_node("right_panel")
	for child: Node in juggling_items.get_children():
		if child.is_in_group("juggling_items"):
			active_juggling_items.push_back(child)
	


func _physics_process(delta: float) -> void:
	if SystemManager.j_done == false:
		timer = 10
		print("juggling")
		infinite = SystemManager.juggle_infinite
		if infinite:
			quit_panel.visible = true
		else:
			quit_panel.visible = false
			if SystemManager.day == 2:
				pass
			elif SystemManager.day == 3:
				pass
		
		TextManager.jfl = player.get_node("left_panel")
		TextManager.jfr = player.get_node("right_panel")
		for child: Node in juggling_items.get_children():
			if child.is_in_group("juggling_items"):
				active_juggling_items.push_back(child)
		SystemManager.j_done = true
	
	if !infinite:
		if timer > 0 && active_juggling_items.size() > 0:
			timer -= delta
		else:
			SystemManager.increment_time()
			SystemManager.open_house(score,active_juggling_items.size())
			SystemManager.calculate_mood()
			finish = true
			print("TIMEOUT")
	else:
		if Input.is_action_just_pressed("ui_open_menu") || active_juggling_items.size() <= 0:
			SystemManager.infinity_max = score
			SystemManager.open_tutorial_menu(null)
			finish = true
		
	
	if score != player.score:
		score = player.score
		update_score_display()
	

func update_score_display():
	var text = str("Score: ", score)
	score_display.text = text 



func _on_dampener_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_items"):
		if body.is_in_group("ball"):
			body.velocity.y = 0
		
	

func _on_dampener_body_exited(body: Node2D) -> void:
	pass
	#if body.is_in_group("juggling_items"):
		#if body.is_in_group("ball"):
		#	body.gravity = Vector2(0,8.5)



func _on_out_bound_detector_body_entered(body: Node2D) -> void:
	print(active_juggling_items)
	if active_juggling_items.has(body):
		active_juggling_items.erase(body)
		print(active_juggling_items.size())
