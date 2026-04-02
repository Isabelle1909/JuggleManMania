extends Node2D

@onready var ui_scr = $text_ui
@onready var text_box = $text_ui/Control
@onready var player = $player
@onready var camera = $Camera2D
@onready var adjustment = get_viewport_rect().size/2

var inst

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if text_box.visible:
		player.disabled = true
	TextManager.tb = text_box

func open_juggling():
	print(adjustment)
	inst = SystemManager.inst()
	inst.position.x = (player.position.x - get_viewport_rect().size.x / 2)
	inst.position.y = (player.position.y - get_viewport_rect().size.y / 2)
	

	
	if inst.position.y > 910 - get_viewport_rect().size.y:
		inst.position.y = 910 - get_viewport_rect().size.y
	elif inst.position.y < -190:
		inst.position.y = -190
	
	add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("test input 1"):
		inst = SystemManager.inst()
		add_child(inst)
	if Input.is_action_just_pressed("test input 2"):
		if is_instance_valid(inst):
			inst.free()
