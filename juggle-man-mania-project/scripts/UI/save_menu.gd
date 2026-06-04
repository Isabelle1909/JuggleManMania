extends Control


#@export var fileName : LineEdit
@onready var dayLabel = $"Panel/Save data/day_number"
@onready var jpLabel =  $"Panel/Save data/current_jp_number"
@onready var scoreLabel = $"Panel/Save data/total_score_number"
@onready var currentDay = $"Panel/Current data/day_number"
@onready var currentJp = $"Panel/Current data/current_jp_number"
@onready var currentTotalScore = $"Panel/Current data/total_score_number"
@onready var saveSlotLabel = $Panel/Labels/Label_SaveSlot1

var default_pos = (Vector2(-23, 46))
var current_save_slot = {}

var slot_default_data = {
	"day": 1,
	"current_jp": 0,
	"total_jp": 0,
	
	"tutorial_score": 0,
	"infinity_score": 0,
	
	"house_pos": Vector2(-23, 46),
	"balc_pos": Vector2(-23,46),
	"location": "house",
	"mood": "neutral",
	"time": "morning",
	
	"talked_to_nums": {},
	"talked_cutscene_nums": {},
	
	"in_costume": false,
	"tutorial_done": false
}

var slot_1_data = slot_default_data

var slot_2_data = slot_default_data

var slot_3_data = slot_default_data

var slot = 1

func _initializingSave(config) -> void:
	if !config.has_section_key("save_slots", "1"):
		config.set_value("save_slots", "1", slot_1_data)
	
	if !config.has_section_key("save_slots", "2"):
		config.set_value("save_slots", "2", slot_2_data)
	
	if !config.has_section_key("save_slots", "3"):
		config.set_value("save_slots", "3", slot_3_data)
	
	update_text()

func _save() -> void: 
	var config = ConfigFile.new()
	var result = config.load("user://juggle_man_saves.cfg")
	if result == OK:
		if !set_current_slot():
			_initializingSave(config)
		
		update_slot()
		config.set_value("save_slots", "1", slot_1_data)
		config.set_value("save_slots", "2", slot_2_data)
		config.set_value("save_slots", "3", slot_3_data)
	
	config.save("user://juggle_man_saves.cfg")
	update_text()



func update_slot() -> void:
	
	set_current_slot()
	
	current_save_slot["day"] = SystemManager.day
	current_save_slot["current_jp"] = SystemManager.current_jp
	current_save_slot["total_jp"] = SystemManager.total_jp
	
	current_save_slot["tutorial_score"] = SystemManager.tutorial_max
	current_save_slot["infinity_score"] = SystemManager.infinity_max
	
	current_save_slot["house_pos"] = SystemManager.house_position
	current_save_slot["balc_pos"] = SystemManager.balc_position
	current_save_slot["location"] = SystemManager.location
	current_save_slot["mood"] = SystemManager.mood
	current_save_slot["time"] = SystemManager.time
	
	current_save_slot["talked_to_nums"] = TextManager.talked_to_nums
	current_save_slot["talked_cutscene_nums"] = TextManager.talked_cutscene_nums
	
	current_save_slot["in_costume"] = SystemManager.in_costume
	current_save_slot["tutorial_done"] = SystemManager.tutorial_done
	
	if slot == 1:
		slot_1_data.assign(current_save_slot)
	elif slot == 2:
		slot_2_data.assign(current_save_slot)
	elif slot == 3:
		slot_3_data.assign(current_save_slot)
	
	update_text()

func update_text() -> void:
	set_current_slot()
	dayLabel.text = str(current_save_slot["day"])
	jpLabel.text = str(current_save_slot["current_jp"])
	scoreLabel.text =  str(current_save_slot["total_jp"])
	
	currentDay.text = str(SystemManager.day)
	currentJp.text = str(SystemManager.current_jp)
	currentTotalScore.text = str(SystemManager.total_jp)

func _ready() -> void:
	$Panel/Buttons/Button_Save.grab_focus.call_deferred()
	slot = 1
	_preload()

func _load() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://juggle_man_saves.cfg")
	if result == OK:
		set_current_slot()
		
		SystemManager.day = config.get_value("save_slots", str(slot))["day"]
		SystemManager.total_jp = config.get_value("save_slots", str(slot))["total_jp"]
		SystemManager.current_jp = config.get_value("save_slots", str(slot))["current_jp"]
		
		SystemManager.tutorial_max = config.get_value("save_slots", str(slot))["tutorial_score"]
		SystemManager.infinity_max = config.get_value("save_slots", str(slot))["infinity_score"]
		
		SystemManager.balc_position = config.get_value("save_slots",str(slot))["balc_pos"]
		SystemManager.house_position = config.get_value("save_slots", str(slot))["house_pos"]
		SystemManager.location = config.get_value("save_slots", str(slot))["location"]
		SystemManager.mood = config.get_value("save_slots", str(slot))["mood"]
		SystemManager.time = config.get_value("save_slots", str(slot))["time"]
		
		TextManager.talked_to_nums = config.get_value("save_slots", str(slot))["talked_to_nums"]
		TextManager.talked_cutscene_nums = config.get_value("save_slots", str(slot))["talked_cutscene_nums"]
		
		SystemManager.in_costume = config.get_value("save_slots", str(slot))["in_costume"]
		SystemManager.tutorial_done = config.get_value("save_slots", str(slot))["tutorial_done"]
		
		update_slot()
		update_text()
	else:
		printerr("oh no!")
		

func _preload() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://juggle_man_saves.cfg")
	set_current_slot()
	if result == OK:
		if config.has_section_key("save_slots", str(slot)):
			current_save_slot = config.get_value("save_slots", str(slot))
	else:
		_initializingSave(config)
	
	update_text()


func _close() -> void:
	SystemManager.open_house(0, 0)


func _delete() -> void:
	var config = ConfigFile.new()
	var result = config.load("user://juggle_man_saves.cfg")
	if result == OK:
		if !set_current_slot():
			_initializingSave(config)
			
		
		if slot == 1:
			slot_1_data.assign(slot_default_data)
		elif slot == 2:
			slot_2_data.assign(slot_default_data)
		elif slot == 3:
			slot_3_data.assign(slot_default_data)
		
		config.set_value("save_slots", "1", slot_1_data)
		config.set_value("save_slots", "2", slot_2_data)
		config.set_value("save_slots", "3", slot_3_data)
	
	config.save("user://juggle_man_saves.cfg")
	update_text()

func set_current_slot() -> bool:
	if slot == 1:
		current_save_slot.assign(slot_1_data)
	elif slot == 2:
		current_save_slot.assign(slot_2_data)
	elif slot == 3:
		current_save_slot.assign(slot_3_data)
	else:
		return false
	return true

func _next() -> void:
	slot += 1 
	if slot > 3:
		slot = 1
	
	set_current_slot()
	
	saveSlotLabel.text = str("Save Slot ", slot)
	
	update_text()


func _back() -> void:
	slot -= 1
	if slot < 1:
		slot = 3
	
	set_current_slot()
	
	saveSlotLabel.text = str("Save Slot ", slot)
	
	update_text()
