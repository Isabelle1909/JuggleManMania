extends Control


#@export var fileName : LineEdit
@onready var dayLabel = $Panel/VBoxContainer_Right/day_number
@onready var jpLabel =  $Panel/VBoxContainer_Right/current_jp_number
@onready var scoreLabel = $Panel/VBoxContainer_Right/total_score_number
var slot_1_day 
var slot_1_jp
var slot_1_score
var slot = 1

func _save() -> void: 
	var config = ConfigFile.new()
	config.set_value("Save Slot 1", "day", SystemManager.day)
	config.set_value("Save Slot 1", "total_jp", SystemManager.total_jp)
	config.set_value("Save Slot 1", "current_jp", SystemManager.current_jp)
	config.save("user://saves.cfg")
	update_slot()
	update_text()

func update_slot() -> void:
	if slot == 1:
		slot_1_day = SystemManager.day
		slot_1_jp = SystemManager.current_jp
		slot_1_score = SystemManager.total_jp

func update_text() -> void:
	if slot == 1:
		dayLabel.text = str(slot_1_day)
		jpLabel.text = str(slot_1_jp)
		scoreLabel.text = str(slot_1_score)
		print("wasgood")

func _ready() -> void:
	_preload()


func _load() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://saves.cfg")
	
	
	if result == OK:
		if slot == 1:
			SystemManager.day = config.get_value("Save Slot 1", "day")
			SystemManager.total_jp = config.get_value("Save Slot 1", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 1", "current_jp")
			update_slot()
			update_text()
	else:
		printerr("oh no!")

func _preload() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://saves.cfg")
	if result == OK:
		slot_1_day = config.get_value("Save Slot 1", "day")
		slot_1_jp = config.get_value("Save Slot 1", "total_jp")
		slot_1_score = config.get_value("Save Slot 1", "current_jp")
		update_text()
	else:
		printerr("ruhroh")
		#a


func _close() -> void:
	SystemManager.open_house(0, 0)
