extends Node2D

@onready var new_game = $button_new_game

func _ready() -> void:
	new_game.grab_focus.call_deferred()

func _on_button_new_game_pressed() -> void:
	SystemManager.open_house(0,0)


func _load() -> void:
	SystemManager.open_house(0,0)
	SystemManager.open_save_menu(Vector2(0, 0))
