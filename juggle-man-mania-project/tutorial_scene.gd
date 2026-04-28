extends Node2D


@onready var text_ui = $text_ui
@onready var text_box = $text_ui/Control

enum progess {HANDS, NMBALL1, MBALL1, MBALL2}

func _ready() -> void:
	text_ui.get_node("Control2").visible = false
	text_box.position = Vector2(0,0)

func warm_up():
	pass
