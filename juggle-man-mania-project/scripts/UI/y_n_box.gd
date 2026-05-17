extends Control

@onready var no = $Panel/no_button
@onready var yes = $Panel/yes_button

signal answered(answer: bool)

func redirect_focus():
	no.grab_focus.call_deferred()

func _ready() -> void:
	
	no.grab_focus.call_deferred()


func _on_yes_button_pressed() -> void:
	answered.emit(true)

func _on_no_button_pressed() -> void:
	answered.emit(false)
