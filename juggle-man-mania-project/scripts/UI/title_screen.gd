extends Node2D

@onready var button_help = $button_help
@onready var help_menu = $help_menu
@onready var click_sound = $ClickSound
var help_open = false

func _ready() -> void:
	
	button_help.grab_focus.call_deferred()

func _on_button_new_game_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	SystemManager.open_house(0,0)


func _load() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	SystemManager.open_house(0,0)
	SystemManager.open_save_menu(Vector2(0, 0))


func _on_button_help_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	if help_open == false:
		help_menu.visible = true
		help_open = true
	else:
		help_menu.visible = false
		help_open = false


func _on_button_quit_pressed() -> void:
	click_sound.play()
	get_tree().quit() # default behavior
