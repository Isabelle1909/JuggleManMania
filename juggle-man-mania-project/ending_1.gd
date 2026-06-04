extends Node2D

@onready var text_ui = $text_ui
@onready var text_box = $text_ui/text_box
@onready var fin = $fin_label
var line = 1
var ex

func _ready() -> void:
	text_ui.get_node("button_info").visible = false
	if SystemManager.mood.contains("neutral"):
		ex = "ending_2"
	elif SystemManager.mood.contains("good"):
		ex = "ending_1"
	elif SystemManager.mood.contains("bad"):
		ex = "ending_3"
	text_box.get_node("Panel/RichTextLabel").text = "..."
	text_box.visible = true
	fin.visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		print("line: ", line)
		if line <= TextManager.talked_cutscene_nums[ex]:
			print("text")
			TextManager.display_cutscene_text("ending_texts",str(ex),str(line),text_box)
			line += 1
		else:
			print("fin")
			fin.visible = true
