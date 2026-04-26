extends Control


#@export var fileName : LineEdit
@onready var dayLabel = $"Panel/Save data/day_number"
@onready var jpLabel =  $"Panel/Save data/current_jp_number"
@onready var scoreLabel = $"Panel/Save data/total_score_number"
@onready var currentDay = $"Panel/Current data/day_number"
@onready var currentJp = $"Panel/Current data/current_jp_number"
@onready var currentTotalScore = $"Panel/Current data/total_score_number"
@onready var saveSlotLabel = $Panel/Labels/Label_SaveSlot1
var slot_1_day = 1
var slot_1_jp = 0
var slot_1_score = 0
var slot_2_day = 1
var slot_2_jp = 0
var slot_2_score = 0
var slot_3_day = 1
var slot_3_jp = 0
var slot_3_score = 0
var slot = 1


func _save() -> void: 
	var config = ConfigFile.new()
	config.set_value("Save Slot 1", "day", slot_1_day)
	config.set_value("Save Slot 1", "total_jp", slot_1_jp)
	config.set_value("Save Slot 1", "current_jp", slot_1_score)
	config.set_value("Save Slot 2", "day", slot_2_day)
	config.set_value("Save Slot 2", "total_jp", slot_2_jp)
	config.set_value("Save Slot 2", "current_jp", slot_2_score)
	config.set_value("Save Slot 3", "day", slot_3_day)
	config.set_value("Save Slot 3", "total_jp", slot_3_jp)
	config.set_value("Save Slot 3", "current_jp", slot_3_score)
	if slot == 1:
		config.set_value("Save Slot 1", "day", SystemManager.day)
		config.set_value("Save Slot 1", "total_jp", SystemManager.total_jp)
		config.set_value("Save Slot 1", "current_jp", SystemManager.current_jp)
		
	elif slot == 2:
		config.set_value("Save Slot 2", "day", SystemManager.day)
		config.set_value("Save Slot 2", "total_jp", SystemManager.total_jp)
		config.set_value("Save Slot 2", "current_jp", SystemManager.current_jp)
		
	elif slot == 3:
		config.set_value("Save Slot 3", "day", SystemManager.day)
		config.set_value("Save Slot 3", "total_jp", SystemManager.total_jp)
		config.set_value("Save Slot 3", "current_jp", SystemManager.current_jp)
		
	config.save("user://saves.cfg")
	update_slot()
	update_text()


func update_slot() -> void:
	if slot == 1:
		slot_1_day = SystemManager.day
		slot_1_jp = SystemManager.current_jp
		slot_1_score = SystemManager.total_jp
	elif slot == 2:
		slot_2_day = SystemManager.day
		slot_2_jp = SystemManager.current_jp
		slot_2_score = SystemManager.total_jp
	elif slot == 3:
		slot_3_day = SystemManager.day
		slot_3_jp = SystemManager.current_jp
		slot_3_score = SystemManager.total_jp
		

func update_text() -> void:
	if slot == 1:
		dayLabel.text = str(slot_1_day)
		jpLabel.text = str(slot_1_jp)
		scoreLabel.text = str(slot_1_score)
		print("wasgood")
	elif slot == 2:
		dayLabel.text = str(slot_2_day)
		jpLabel.text = str(slot_2_jp)
		scoreLabel.text = str(slot_2_score)
		print("wasgood")
	elif slot == 3:
		dayLabel.text = str(slot_3_day)
		jpLabel.text = str(slot_3_jp)
		scoreLabel.text = str(slot_3_score)
		print("wasgood")
	
	currentDay.text = str(SystemManager.day)
	currentJp.text = str(SystemManager.current_jp)
	currentTotalScore.text = str(SystemManager.total_jp)

func _ready() -> void:
	slot = 0
	_save()
	slot = 1
	_preload()


func _load() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://saves.cfg")
	
	
	if result == OK:
		if slot == 1:
			SystemManager.day = config.get_value("Save Slot 1", "day")
			SystemManager.total_jp = config.get_value("Save Slot 1", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 1", "current_jp")
		elif slot == 2:
			SystemManager.day = config.get_value("Save Slot 2", "day")
			SystemManager.total_jp = config.get_value("Save Slot 2", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 2", "current_jp")
		elif slot == 3:
			SystemManager.day = config.get_value("Save Slot 3", "day")
			SystemManager.total_jp = config.get_value("Save Slot 3", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 3", "current_jp")
			
		update_slot()
		update_text()
	else:
		printerr("oh no!")
		

func _preload() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://saves.cfg")
	if result == OK:
		if slot == 1:
			slot_1_day = config.get_value("Save Slot 1", "day")
			slot_1_jp = config.get_value("Save Slot 1", "total_jp")
			slot_1_score = config.get_value("Save Slot 1", "current_jp")
		elif slot == 2:
			slot_2_day = config.get_value("Save Slot 2", "day")
			slot_2_jp = config.get_value("Save Slot 2", "total_jp")
			slot_2_score = config.get_value("Save Slot 2", "current_jp")
		elif slot == 3:
			slot_3_day = config.get_value("Save Slot 3", "day")
			slot_3_jp = config.get_value("Save Slot 3", "total_jp")
			slot_3_score = config.get_value("Save Slot 3", "current_jp")
		update_text()
	else:
		if slot == 1:
			slot_1_day = 1
			slot_1_jp = 0
			slot_1_score = 0
		elif slot == 2:
			slot_2_day = 1
			slot_2_jp = 0
			slot_2_score = 0
		elif slot == 3:
			slot_3_day = 1
			slot_3_jp = 0
			slot_3_score = 0
		update_text()
		


func _close() -> void:
	SystemManager.open_house(0, 0)


func _delete() -> void:
	var config = ConfigFile.new()
	if slot == 1:
		config.set_value("Save Slot 1", "day", 1)
		config.set_value("Save Slot 1", "total_jp", 0)
		config.set_value("Save Slot 1", "current_jp",0)
		config.save("user://saves.cfg")
		
		slot_1_day = 1
		slot_1_jp = 0
		slot_1_score = 0
	elif slot == 2:
		config.set_value("Save Slot 2", "day", 1)
		config.set_value("Save Slot 2", "total_jp", 0)
		config.set_value("Save Slot 2", "current_jp",0)
		config.save("user://saves.cfg")
		
		slot_2_day = 1
		slot_2_jp = 0
		slot_2_score = 0
		
	elif slot == 3:
		config.set_value("Save Slot 3", "day", 1)
		config.set_value("Save Slot 3", "total_jp", 0)
		config.set_value("Save Slot 3", "current_jp",0)
		config.save("user://saves.cfg")
		
		slot_3_day = 1
		slot_3_jp = 0
		slot_3_score = 0
	
	update_text()


func _next() -> void:
	slot += 1 
	if slot > 3:
		slot = 1
	
	saveSlotLabel.text = str("Save Slot ", slot)
	_preload()


func _back() -> void:
	slot -= 1
	if slot < 1:
		slot = 3
	
	saveSlotLabel.text = str("Save Slot ", slot)
	_preload()
