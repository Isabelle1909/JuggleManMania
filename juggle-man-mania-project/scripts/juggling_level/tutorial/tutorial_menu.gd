extends Control

@onready var tutorial_button = $Panel/tutorial_start
@onready var congrats = $congrats
@onready var tut_max = $Panel/tutorial_score
@onready var inf_max = $Panel/infinity_score



func _ready() -> void:
	tut_max.text = str(SystemManager.tutorial_max)
	inf_max.text = str(SystemManager.infinity_max)
	if SystemManager.tut_just_done:
		congrats.visible = true
		SystemManager.tut_just_done = false
	else:
		tutorial_button.grab_focus.call_deferred()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") && congrats.visible:
		congrats.visible = false
		tutorial_button.grab_focus.call_deferred()


func _on_tutorial_start_pressed() -> void:
	
	SystemManager.open_tutorial()


func _on_infinite_mode_start_pressed() -> void:
	SystemManager.juggle_infinite = true
	SystemManager.open_juggling(null)



func _on_close_pressed() -> void:
	SystemManager.open_house(0,0)
