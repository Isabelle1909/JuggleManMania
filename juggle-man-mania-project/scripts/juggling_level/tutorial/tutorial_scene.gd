extends Node2D


@onready var text_ui = $text_ui
@onready var text_box = $text_ui/text_box
@onready var j_player = $juggling_player
@onready var left_panel = $juggling_player/left_panel
@onready var right_panel = $juggling_player/right_panel
@onready var left_feedback = $juggling_player/left_panel/left_feedback
@onready var right_feedback = $juggling_player/right_panel/right_feedback
@onready var time_display = $text_ui/timer_display
@onready var timer_text = $text_ui/timer_display/Panel/time_number
@onready var score_display = $text_ui/score_display
@onready var score_text = $text_ui/score_display/Panel/score_number
@onready var button_info = $text_ui/button_info


var ball = load("res://scenes/juggling_level/juggling_items/manual_physics_ball.tscn")

enum PROGRESS {HANDS, NMBALL1, MBALL1, MBALL2, EXPLANATION, FINISH, SLOWBALL}
var section = PROGRESS.EXPLANATION
var line = 1
var ex = -1

var sub_score = 0
var score = 0
var begin_score = 0

var left_hand = true
var stretch = 0
var stretch_max = 3

var last_done = []
var last_done_max = 3

var ball_1 = ball.instantiate()
var ball_2 = ball.instantiate()
var ball_3 = ball.instantiate()
var ball_4 = ball.instantiate()

var heard = false
var begun = false
var finished = false
var dropped = []

var timer = 0
var m1_timer = 10
var m2_timer = 5

func _ready() -> void:
	button_info.visible = false
	SystemManager.tutorial_done = true
	
	text_box.position = Vector2(0,0)
	TextManager.tb = text_box
	TextManager.display_cutscene_text("tutorial",str("-1"),str(line),text_box)
	line += 1
	
	score_display.visible = true
	
	left_feedback.text = "J"
	right_feedback.text = "L"

	
	j_player.move_only_disabled = true
	
	ball_1.remove_x_velocity()
	ball_4.reduce_speed(4.0)
	
	ball_1.name = "ball_1"
	ball_2.name = "ball_2"
	ball_3.name = "ball_3"
	ball_4.name = "ball_4"
	

func _physics_process(delta: float) -> void:
	if section == PROGRESS.HANDS:
		hands()
	elif section == PROGRESS.NMBALL1:
		NMball1()
	elif section == PROGRESS.MBALL1:
		Mball1(delta)
	elif section == PROGRESS.MBALL2:
		Mball2(delta)
	elif section == PROGRESS.SLOWBALL:
		slow_ball(delta)
	elif section == PROGRESS.FINISH:
		finish()
	elif section == PROGRESS.EXPLANATION:
			explanation()
	
	if Input.is_action_just_pressed("ui_open_menu"):
		finish()



func update_score(num):
	sub_score += num
	score = j_player.score + sub_score
	print(sub_score, " in_update")
	score_text.text = str(score)

func hands():
	#print("stretch: ",stretch)
	if Input.is_action_just_pressed("interact"):
		if left_hand:
			left_panel.visible = false
			left_hand = false
			right_panel.visible = true
			stretch += 1
			update_score(5)
	elif Input.is_action_just_pressed("back"):
		if !left_hand:
			right_panel.visible = false
			left_hand = true
			left_panel.visible = true
			stretch += 1
			update_score(5)
	if stretch > stretch_max:
		TextManager.jfl = left_panel
		TextManager.jfr = right_panel
		update_score(10)
		between_text("-1","3",true)

func NMball1():
	if check_last():
		j_player.disabled = true
		between_text("0","2",true)
		
	if Input.is_action_just_pressed("interact"):
		print("la: ", ball_1.get_last_accuracy())
		last_done.append(ball_1.get_last_accuracy())
		if last_done.size() > last_done_max:
			last_done.remove_at(0)

func between_text(sec,lin,com):
	if !TextManager.tb.visible:
		TextManager.tb.visible = true
		TextManager.display_cutscene_text("tutorial",sec,lin,null)
		print("ahh")
		if com == true:
			section = PROGRESS.EXPLANATION
		else:
			ex -= 1
			section = PROGRESS.EXPLANATION



func Mball1(delta):
	if (Input.is_action_just_pressed("back") || Input.is_action_just_pressed("interact")):
		if !begun:
			begun = true
			timer = 0
		update_score(0)
		
	
	if begun:
		timer_process(delta,m1_timer)
	
	if finished:
		heard = false
		between_text("2","4",true)

func slow_ball(delta):
	if (Input.is_action_just_pressed("back") || Input.is_action_just_pressed("interact")):
		if !begun:
			begun = true
			timer = 0
		update_score(0)
	
	if begun:
		timer_process(delta,m1_timer)
	
	if finished:
		heard = false
		between_text("1","3",true)

func Mball2(delta):
	if (Input.is_action_just_pressed("back") || Input.is_action_just_pressed("interact")):
		if !begun:
			begun = true
			timer = 0
		update_score(0)
	
	if begun:
		timer_process(delta,m2_timer)
	
	if finished:
		heard = false
		between_text("2","3",true)

func timer_process(delta,max_time):
	var display_num = 0
	
	timer += delta
	display_num = max_time - roundi(timer)
	timer_text.text = str(display_num)

	if timer > max_time:
		finished = true
		time_display.visible = false

func finish():
	if SystemManager.tutorial_max < score:
		SystemManager.tutorial_max = score
		print(SystemManager.tutorial_max)
	
	SystemManager.tut_just_done = true
	SystemManager.open_tutorial_menu(null)
	#SystemManager.open_house(0,0)


func check_last() -> bool:
	if last_done.size() == 3:
		if last_done[0] == last_done[1] && last_done[1 ] == last_done[2] && last_done[0].contains("perfect"):
			return true
	return false

func explanation():
	if ex >= 5:
		section = PROGRESS.FINISH
	if Input.is_action_just_pressed("interact"):
		print("line: ", line)
		j_player.disabled = true
		if line <= TextManager.talked_cutscene_nums[str(ex)] && !heard:
			print("text")
			TextManager.display_cutscene_text("tutorial",str(ex),str(line),text_box)
		else:
			line = 0
			TextManager.close_text(text_box)
			j_player.disabled = false
			print(ex)
			if ex == -1:
				section = PROGRESS.HANDS
				left_panel.visible = true
				print(ex, " -1")
			if ex == 0:
				if !get_tree().root.has_node("ball_1"):
					get_tree().root.add_child(ball_1)
				section = PROGRESS.NMBALL1
				ball_1.position = Vector2(500,450)
				update_score(0) 
			elif ex == 1:
				sub_score = score
				print(sub_score, " sub_score")
				j_player.score = 0
				print(ex, " 1")
				print("slowball")
				section = PROGRESS.SLOWBALL
				if get_tree().root.has_node("ball_1"):
					get_tree().root.remove_child(ball_1)
				if !get_tree().root.has_node("ball_4"):
					get_tree().root.add_child(ball_4)
				time_display.visible = true
				j_player.move_only_disabled = false
				j_player.position = Vector2(565,526)
				ball_4.velocity.x = 0
				ball_4.position = Vector2(625,400)
				timer = 0
				begun = false
				finished = false
				#section = PROGRESS.NMBALL1
				#get_tree().root.add_child(ball_1)
				#ball_1.position = Vector2(500,450)
				update_score(0) 
			elif ex == 2:
				sub_score = score
				print(sub_score, " sub_score")
				j_player.score = 0
				print(ex, " 2")
				print("noraml ball")
				section = PROGRESS.MBALL1
				if get_tree().root.has_node("ball_4"):
					print("ball remove")
					get_tree().root.remove_child(ball_4)
				if get_tree().root.has_node("ball_1"):
					print("ball remove")
					get_tree().root.remove_child(ball_1)
				if !get_tree().root.has_node("ball_2"):
					get_tree().root.add_child(ball_2)
				time_display.visible = true
				j_player.move_only_disabled = false
				j_player.position = Vector2(565,526)
				ball_2.velocity.x = 0
				ball_2.position = Vector2(625,400)
				timer = 0
				begun = false
				finished = false
				update_score(0) 
			elif ex == 3: 
				sub_score = score
				print(sub_score, " sub_score")
				j_player.score = 0
				print(ex, " 3")
				section = PROGRESS.MBALL2
				if get_tree().root.has_node("ball_1"):
					get_tree().root.remove_child(ball_1)
				if !get_tree().root.has_node("ball_2"):
					get_tree().root.add_child(ball_2)
				if !get_tree().root.has_node("ball_4"):
					get_tree().root.add_child(ball_4)
				ball_4.reduce_speed(6.0)
				time_display.visible = true
				j_player.move_only_disabled = false
				j_player.position = Vector2(565,526)
				ball_2.velocity.x = 0
				ball_2.position = Vector2(625,400)
				ball_4.velocity.x = 0
				ball_4.position = Vector2(500,400)
				timer = 0
				begun = false
				finished = false
				update_score(0) 
			print("inc ex")
			ex += 1
		
		line += 1

func reset_phase():
	if section == PROGRESS.SLOWBALL:
		score = sub_score
		between_text("1","2",false)
		heard = true
	if section == PROGRESS.MBALL1:
		between_text("2","3", false)
		heard = true
		score = sub_score
	elif section == PROGRESS.MBALL2:
		dropped.clear()
		between_text("3","2", false)
		heard = true
		score = sub_score

func _on_ball_drop_detect_body_entered(body: Node2D) -> void:
	if body.name.contains("ball_4") && section == PROGRESS.SLOWBALL: 
		reset_phase()
	if body.name.contains("ball_2") && section == PROGRESS.MBALL1: 
		reset_phase()
	if body.name.contains("ball_2") || body.name.contains("ball_4") && section == PROGRESS.MBALL2:
		dropped.append(body)
		if dropped.size() >= 2:
			print(dropped)
			reset_phase()
			
