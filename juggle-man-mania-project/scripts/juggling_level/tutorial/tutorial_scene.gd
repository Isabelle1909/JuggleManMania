extends Node2D


@onready var text_ui = $text_ui
@onready var text_box = $text_ui/Control

enum PROGRESS {HANDS, NMBALL1, MBALL1, MBALL2}
var section = PROGRESS.HANDS
var line = 1

func _ready() -> void:
	text_ui.get_node("Control2").visible = false
	text_box.position = Vector2(0,0)


func _physics_process(delta: float) -> void:
	TextManager.display_cutscene_text("tutorial",str(section),line)
