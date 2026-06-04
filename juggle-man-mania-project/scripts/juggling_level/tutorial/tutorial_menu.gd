extends Control

@onready var tutorial_button = $Panel/tutorial_start

var tut_high_score
var inf_high_score

func _ready() -> void:
	tutorial_button.grab_focus.call_deferred()

func update_displayed_scores():
	tut_high_score = SystemManager.tutorial_max
	inf_high_score = SystemManager.infinity_max

func update_recorded_scores(tut,inf):
	SystemManager.tutorial_max = tut
	SystemManager.infinity_max = inf



func _on_tutorial_start_pressed() -> void:
	SystemManager.open_tutorial()

func _on_infinite_mode_start_pressed() -> void:
	print("infinity")



func _on_close_pressed() -> void:
	SystemManager.open_house(0,0)
