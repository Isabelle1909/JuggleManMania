extends Node2D

@onready var ui_scr = $text_ui
@onready var text_box = $text_ui/Control
@onready var help_menu = $text_ui/Control2
@onready var result_scr = $text_ui/Control3
@onready var player = $player
@onready var adjustment = get_viewport_rect().size/2
@onready var saveMenu = $text_ui/Load

var on_entered_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	help_menu.visible = true
	if !on_entered_done:
		on_entered()
		on_entered_done = true
	
	if text_box.visible:
		player.disabled = true
	TextManager.tb = text_box
	TextManager.hm = help_menu
	TextManager.rs = result_scr
	

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


func results_screen(score,bonus_1):
	result_scr.visible = true
	var sc = result_scr.get_node("Panel/Label_ScoreNumber")
	var bs1 = result_scr.get_node("Panel/VBoxContainer_Right/Label_Item1")
	sc.text = str(score)
	bs1.text = str(bonus_1)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_open_menu"):
		SystemManager.open_save_menu(player.position)
