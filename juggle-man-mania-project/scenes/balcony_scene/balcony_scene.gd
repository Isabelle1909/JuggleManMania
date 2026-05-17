extends Node2D

var set_position
var position_set = false

@onready var parent = self.get_parent()
@onready var player_b = $player
@onready var camera = player_b.get_node("Camera2D")
@onready var text_box = $text_ui/text_box

func _ready() -> void:
	TextManager.close_text(null,null)

func disable_balc_player():
	player_b.true_disabled = true
	camera.enabled = false

func enable_balc_player():
	player_b.true_disabled = false
	camera.enabled = true
