extends Node2D



func _on_button_new_game_pressed() -> void:
	SystemManager.open_house(0,0)


func _load() -> void:
	SystemManager.open_house(0,0)
	SystemManager.open_save_menu(Vector2(0, 0))
