extends Node2D

@onready var ui_scr = $text_ui
@onready var text_box = $text_ui/Control
@onready var help_menu = $text_ui/Control2
@onready var result_scr = $text_ui/Control3
@onready var player = $player
@onready var camera = $Camera2D
@onready var adjustment = get_viewport_rect().size/2

var on_entered_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		if SystemManager.last_score != null:
			results_screen(SystemManager.last_score,SystemManager.last_bonus_1)
		player.position = SystemManager.house_position
	else:
		print("house_pos ", SystemManager.house_position)


func results_screen(score,bonus_1):
	result_scr.visible = true
	var sc = result_scr.get_node("Panel/Label_ScoreNumber")
	var bs1 = result_scr.get_node("Panel/VBoxContainer_Right/Label_Item1")
	sc.text = str(score)
	bs1.text = str(bonus_1)
