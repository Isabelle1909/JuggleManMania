extends Node2D


@onready var text_ui = $text_ui
@onready var text_box = $text_ui/text_box

@onready var j_player = $juggling_player
@onready var left_feedback = $juggling_player/left_feedback
@onready var right_feedback = $juggling_player/right_feedback

var ball = load("res://scenes/juggling_level/juggling_items/manual_physics_ball.tscn")

enum PROGRESS {HANDS, NMBALL1, MBALL1, MBALL2, EXPLANATION}
var section = PROGRESS.EXPLANATION
var line = 1
var ex = 0

var left_hand = true
var stretch = 0
var stretch_max = 5

var ball_1 = ball.instantiate()
var ball_2 = ball.instantiate()

func _ready() -> void:
	#text_ui.get_node("help_menu").visible = false
	text_box.position = Vector2(0,0)
	TextManager.tb = text_box
	TextManager.display_cutscene_text("tutorial",str(section),str(line),text_box)
	
	left_feedback.text = "J"
	right_feedback.text = "L"
	
	j_player.move_only_disabled = true
	
	ball_1.remove_x_velocity()
	




func _physics_process(delta: float) -> void:

	if section == PROGRESS.HANDS:
		hands()
	elif section == PROGRESS.NMBALL1:
		NMball1()
	elif section == PROGRESS.EXPLANATION:
			explanation()

	
	

func hands():
	#print("stretch: ",stretch)
	if Input.is_action_just_pressed("interact"):
		if left_hand:
			left_feedback.visible = false
			left_hand = false
			right_feedback.visible = true
			stretch += 1
	elif Input.is_action_just_pressed("back"):
		if !left_hand:
			right_feedback.visible = false
			left_hand = true
			left_feedback.visible = true
			stretch += 1
	if stretch > stretch_max:
		section = PROGRESS.EXPLANATION
		


func NMball1():
	pass


func explanation():
	if Input.is_action_just_pressed("interact"):
		print("line: ", line)
		j_player.disabled = true
		if line <= TextManager.talked_cutscene_nums[str(ex)]:
			print("text")
			TextManager.display_cutscene_text("tutorial",str(ex),str(line),text_box)
		else:
			line = 0
			TextManager.close_text(null,text_box)
			j_player.disabled = false
			if ex == 0:
				section = PROGRESS.HANDS
				left_feedback.visible = true
			elif ex == 1:
				section = PROGRESS.NMBALL1
				get_tree().root.add_child(ball_1)
				ball_1.position = Vector2(500,200)
			
			ex += 1
		
		line += 1
	
