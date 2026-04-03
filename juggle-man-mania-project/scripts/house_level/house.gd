extends Node2D

@onready var ui_scr = $text_ui
@onready var text_box = $text_ui/Control
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

func on_entered():
	if SystemManager.house_position != null:
		text_box.visible = false
		player.position = SystemManager.house_position
	else:
		print("house_pos ", SystemManager.house_position)
