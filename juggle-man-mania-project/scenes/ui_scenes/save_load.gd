extends Control

@export var fileName : LineEdit

func _save() -> void: 
	var config = ConfigFile.new()
	config.set_value("Save Slot 1", "")
