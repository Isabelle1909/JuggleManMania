extends Control


#@export var fileName : LineEdit
@onready var dayLabel = $"Panel/Save data/day_number"
@onready var jpLabel =  $"Panel/Save data/current_jp_number"
@onready var scoreLabel = $"Panel/Save data/total_score_number"
@onready var currentDay = $"Panel/Current data/day_number"
@onready var currentJp = $"Panel/Current data/current_jp_number"
@onready var currentTotalScore = $"Panel/Current data/total_score_number"
@onready var saveSlotLabel = $Panel/Labels/Label_SaveSlot1

var slot_1_data = {
	"day": 1,
	"total_jp": 0,
	"current_jp": 0
}

var slot_1_day = 1
var slot_1_jp = 0
var slot_1_score = 0
var slot_1_pos = (Vector2(-23, 46))
var slot_1_mood = "neutral"
var slot_1_time = "morning" 

var slot_2_day = 1
var slot_2_jp = 0
var slot_2_score = 0
var slot_2_pos = (Vector2(-23, 46))
var slot_2_mood = "neutral"
var slot_2_time = "morning" 

var slot_3_day = 1
var slot_3_jp = 0
var slot_3_score = 0
var slot_3_pos = (Vector2(-23, 46))
var slot_3_mood = "neutral"
var slot_3_time = "morning" 

var slot = 1

func _initializingSave(config) -> void:
	if !config.has_section("Save Slot 1"):
		config.set_value("Save Slot 1", "day", slot_1_day)
		config.set_value("Save Slot 1", "total_jp", slot_1_jp)
		config.set_value("Save Slot 1", "current_jp", slot_1_score)
		config.set_value("Save Slot 1", "pos", slot_1_pos)
		config.set_value("Save Slot 1", "mood", slot_1_mood)
		config.set_value("Save Slot 1", "time", slot_1_time)
		
	if !config.has_section("Save Slot 2"):
		config.set_value("Save Slot 2", "day", slot_2_day)
		config.set_value("Save Slot 2", "total_jp", slot_2_jp)
		config.set_value("Save Slot 2", "current_jp", slot_2_score)
		config.set_value("Save Slot 2", "pos", slot_2_pos)
		config.set_value("Save Slot 2", "mood", slot_2_mood)
		config.set_value("Save Slot 2", "time", slot_2_time)
	
	if !config.has_section("Save Slot 3"):
		config.set_value("Save Slot 3", "day", slot_3_day)
		config.set_value("Save Slot 3", "total_jp", slot_3_jp)
		config.set_value("Save Slot 3", "current_jp", slot_3_score)
		config.set_value("Save Slot 3", "pos", slot_3_pos)
		config.set_value("Save Slot 3", "mood", slot_3_mood)
		config.set_value("Save Slot 3", "time", slot_3_time)

func _save() -> void: 
	var config = ConfigFile.new()
	var result = config.load("user://saves.cfg")
	if result == OK:
	
		if slot == 1:
			config.set_value("Save Slot 1", "day", SystemManager.day)
			config.set_value("Save Slot 1", "total_jp", SystemManager.total_jp)
			config.set_value("Save Slot 1", "current_jp", SystemManager.current_jp)
			config.set_value("Save Slot 1", "pos", SystemManager.house_position)
			config.set_value("Save Slot 1", "mood", SystemManager.mood)
			config.set_value("Save Slot 1", "time", SystemManager.time)
			
		elif slot == 2:
			config.set_value("Save Slot 2", "day", SystemManager.day)
			config.set_value("Save Slot 2", "total_jp", SystemManager.total_jp)
			config.set_value("Save Slot 2", "current_jp", SystemManager.current_jp)
			config.set_value("Save Slot 2", "pos", SystemManager.house_position)
			config.set_value("Save Slot 2", "mood", SystemManager.mood)
			config.set_value("Save Slot 2", "time", SystemManager.time)
			
		elif slot == 3:
			config.set_value("Save Slot 3", "day", SystemManager.day)
			config.set_value("Save Slot 3", "total_jp", SystemManager.total_jp)
			config.set_value("Save Slot 3", "current_jp", SystemManager.current_jp)
			config.set_value("Save Slot 3", "pos", SystemManager.house_position)
			config.set_value("Save Slot 3", "mood", SystemManager.mood)
			config.set_value("Save Slot 3", "time", SystemManager.time)
	
	else:
		_initializingSave(config)
	
	config.save("user://saves.cfg")
	update_slot()
	update_text()



func update_slot() -> void:
	if slot == 1:
		slot_1_day = SystemManager.day
		slot_1_jp = SystemManager.current_jp
		slot_1_score = SystemManager.total_jp
		slot_1_pos = SystemManager.house_position
		slot_1_mood = SystemManager.mood
		slot_1_time = SystemManager.time
		
	elif slot == 2:
		slot_2_day = SystemManager.day
		slot_2_jp = SystemManager.current_jp
		slot_2_score = SystemManager.total_jp
		slot_2_pos = SystemManager.house_position
		slot_2_mood = SystemManager.mood
		slot_2_time = SystemManager.time
		
	elif slot == 3:
		slot_3_day = SystemManager.day
		slot_3_jp = SystemManager.current_jp
		slot_3_score = SystemManager.total_jp
		slot_3_pos = SystemManager.house_position
		slot_3_mood = SystemManager.mood
		slot_3_time = SystemManager.time

func update_text() -> void:
	if slot == 1:
		dayLabel.text = str(slot_1_day)
		jpLabel.text = str(slot_1_jp)
		scoreLabel.text = str(slot_1_score)
	elif slot == 2:
		dayLabel.text = str(slot_2_day)
		jpLabel.text = str(slot_2_jp)
		scoreLabel.text = str(slot_2_score)
	elif slot == 3:
		dayLabel.text = str(slot_3_day)
		jpLabel.text = str(slot_3_jp)
		scoreLabel.text = str(slot_3_score)
	
	currentDay.text = str(SystemManager.day)
	currentJp.text = str(SystemManager.current_jp)
	currentTotalScore.text = str(SystemManager.total_jp)

func _ready() -> void:
	$Panel/Buttons/Button_Save.grab_focus.call_deferred()
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
			SystemManager.house_position = config.get_value("Save Slot 1", "pos")
			SystemManager.mood = config.get_value("Save Slot 1", "mood")
			SystemManager.time = config.get_value("Save Slot 1", "time")
		elif slot == 2:
			SystemManager.day = config.get_value("Save Slot 2", "day")
			SystemManager.total_jp = config.get_value("Save Slot 2", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 2", "current_jp")
			SystemManager.house_position = config.get_value("Save Slot 2", "pos")
			SystemManager.mood = config.get_value("Save Slot 2", "mood")
			SystemManager.time = config.get_value("Save Slot 2", "time")
		elif slot == 3:
			SystemManager.day = config.get_value("Save Slot 3", "day")
			SystemManager.total_jp = config.get_value("Save Slot 3", "total_jp")
			SystemManager.current_jp = config.get_value("Save Slot 3", "current_jp")
			SystemManager.house_position = config.get_value("Save Slot 3", "pos")
			SystemManager.mood = config.get_value("Save Slot 3", "mood")
			SystemManager.time = config.get_value("Save Slot 3", "time")
			
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
			slot_1_pos = config.get_value("Save Slot 1", "pos")
			slot_1_mood = config.get_value("Save Slot 1", "mood")
			slot_1_time = config.get_value("Save Slot 1", "time")
		elif slot == 2:
			slot_2_day = config.get_value("Save Slot 2", "day")
			slot_2_jp = config.get_value("Save Slot 2", "total_jp")
			slot_2_score = config.get_value("Save Slot 2", "current_jp")
			slot_2_pos = config.get_value("Save Slot 2", "pos")
			slot_2_mood = config.get_value("Save Slot 2", "mood")
			slot_2_time = config.get_value("Save Slot 2", "time")
		elif slot == 3:
			slot_3_day = config.get_value("Save Slot 3", "day")
			slot_3_jp = config.get_value("Save Slot 3", "total_jp")
			slot_3_score = config.get_value("Save Slot 3", "current_jp")
			slot_3_pos = config.get_value("Save Slot 3", "pos")
			slot_3_mood = config.get_value("Save Slot 3", "mood")
			slot_3_time = config.get_value("Save Slot 3", "time")
		update_text()
	else:
		if slot == 1:
			slot_1_day = 1
			slot_1_jp = 0
			slot_1_score = 0
			slot_1_pos = (Vector2(-23, 46))
			slot_1_mood = "neutral"
			slot_1_time = "morning" 
		elif slot == 2:
			slot_2_day = 1
			slot_2_jp = 0
			slot_2_score = 0
			slot_1_pos = (Vector2(-23, 46))
			slot_1_mood = "neutral"
			slot_1_time = "morning" 
		elif slot == 3:
			slot_3_day = 1
			slot_3_jp = 0
			slot_3_score = 0
			slot_1_pos = (Vector2(-23, 46))
			slot_1_mood = "neutral"
			slot_1_time = "morning" 
		update_text()
		


func _close() -> void:
	SystemManager.open_house(0, 0,"house")


func _delete() -> void:
	var config = ConfigFile.new()
	if slot == 1:
		config.set_value("Save Slot 1", "day", 1)
		config.set_value("Save Slot 1", "total_jp", 0)
		config.set_value("Save Slot 1", "current_jp",0)
		config.set_value("Save Slot 1", "pos", Vector2(-23, 46))
		config.set_value("Save Slot 1", "mood", "neutral")
		config.set_value("Save Slot 1", "time", "morning")
		config.save("user://saves.cfg")
		
		slot_1_day = 1
		slot_1_jp = 0
		slot_1_score = 0
		slot_1_pos = (Vector2 (-23, 46))
		slot_1_mood = "neutral"
		slot_1_time = "morning"
	elif slot == 2:
		config.set_value("Save Slot 2", "day", 1)
		config.set_value("Save Slot 2", "total_jp", 0)
		config.set_value("Save Slot 2", "current_jp",0)
		config.set_value("Save Slot 2", "pos", Vector2(-23, 46))
		config.set_value("Save Slot 2", "mood", "neutral")
		config.set_value("Save Slot 2", "time", "morning")
		config.save("user://saves.cfg")
		
		slot_2_day = 1
		slot_2_jp = 0
		slot_2_score = 0
		slot_2_pos = (Vector2 (-23, 46))
		slot_2_mood = "neutral"
		slot_2_time = "morning"
		
	elif slot == 3:
		config.set_value("Save Slot 3", "day", 1)
		config.set_value("Save Slot 3", "total_jp", 0)
		config.set_value("Save Slot 3", "current_jp",0)
		config.set_value("Save Slot 3", "pos", Vector2(-23, 46))
		config.set_value("Save Slot 3", "mood", "neutral")
		config.set_value("Save Slot 3", "time", "morning")
		config.save("user://saves.cfg")
		
		slot_3_day = 1
		slot_3_jp = 0
		slot_3_score = 0
		slot_3_pos = (Vector2 (-23, 46))
		slot_3_mood = "neutral"
		slot_3_time = "morning"
	
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
