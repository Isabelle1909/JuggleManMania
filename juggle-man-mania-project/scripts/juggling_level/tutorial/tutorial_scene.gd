extends Node2D


@onready var text_ui = $text_ui
@onready var text_box = $text_ui/Control
@onready var j_player = $juggling_player

enum PROGRESS {HANDS, NMBALL1, MBALL1, MBALL2}
var section = PROGRESS.HANDS
var line = 1

func _ready() -> void:
	text_ui.get_node("Control2").visible = false
	text_box.position = Vector2(0,0)
	TextManager.display_cutscene_text("tutorial",str(section),str(line),text_box)


func _physics_process(delta: float) -> void:
	if text_box.visible:
		explanation()
	

func explanation():
	j_player.disabled = true
	
	if Input.is_action_just_pressed("interact"):
		line += 1
		
		if line <= TextManager.talked_cutscene_nums[str(section)]:
			TextManager.display_cutscene_text("tutorial",str(section),str(line),text_box)
		else:
			TextManager.close_text("none",text_box)
			line = 1
			
	
	
	
