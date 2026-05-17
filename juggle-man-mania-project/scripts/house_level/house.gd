extends Node2D

@onready var ui_scr = $text_ui
@onready var text_box = $text_ui/text_box
@onready var help_menu = $text_ui/help_menu
@onready var result_scr = $text_ui/results_screen
@onready var saveMenu = $text_ui/save_menu
@onready var y_n_box = $text_ui/y_n_box

@onready var player = $player
@onready var camera = player.get_node("Camera2D")
@onready var adjustment = get_viewport_rect().size/2

var on_entered_done


func _ready() -> void:
	y_n_box.answered.connect(_handle_answer)
	
	if !on_entered_done:
		on_entered()
		on_entered_done = true
	
	if text_box.visible:
		player.disabled = true
	TextManager.tb = text_box
	TextManager.hm = help_menu
	TextManager.rs = result_scr
	TextManager.ynb = y_n_box
	

func go_balcony():
	SystemManager.house_position = player.position
	player.global_position = Vector2(550,-2000)

func leave_balcony():
	player.global_position = SystemManager.house_position
	


func _handle_answer(ans: bool):
	if !ans:
		TextManager.close_question()
		player.disabled = false
	elif player.waiting_answer_bed:
		TextManager.close_question()
		player.disabled = false
		SystemManager.increment_time()
	elif player.waiting_answer_door:
		var door = player.object_near
		if door.has_node("DoorSound"):
			door.get_node("DoorSound").play()
		TextManager.close_question()
		on_entered_done = false
		SystemManager.open_juggling(player.position)


func on_entered():
	if SystemManager.house_position != null:
		text_box.visible = false
		help_menu.visible = false
		if SystemManager.just_juggling == true:
			results_screen(SystemManager.last_score,SystemManager.last_bonus_1)
			SystemManager.just_juggling = false
		player.position = SystemManager.house_position
	else:
		print("house_pos ", SystemManager.house_position)
		SystemManager.house_position = player.position
	
	player.true_disabled = false
	camera.enabled = true


func results_screen(score,bonus_1):
	result_scr.visible = true
	var sc = result_scr.get_node("Panel/Label_ScoreNumber")
	var bs1 = result_scr.get_node("Panel/VBoxContainer_Right/Label_Item1")
	sc.text = str(score)
	bs1.text = str(bonus_1)

func _physics_process(delta: float) -> void:
	if SystemManager.go_balc:
		go_balcony()
		SystemManager.go_balc = false
	elif SystemManager.leave_balc:
		leave_balcony()
		SystemManager.leave_balc = false
	if Input.is_action_just_pressed("ui_open_menu"):
		SystemManager.open_save_menu(player.position)
