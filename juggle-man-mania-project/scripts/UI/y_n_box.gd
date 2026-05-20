extends Control

@onready var click_sound = $Panel/ClickSound
@onready var no = $Panel/no_button
@onready var yes = $Panel/yes_button

signal answered(answer: bool)

func redirect_focus():
	no.grab_focus.call_deferred()

func _ready() -> void:
	
	no.grab_focus.call_deferred()


func _on_yes_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	answered.emit(true)

func _on_no_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.1).timeout
	answered.emit(false)
