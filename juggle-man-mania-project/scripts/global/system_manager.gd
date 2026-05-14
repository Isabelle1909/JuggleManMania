extends Node

var time = "morning"
var day = 1
var mood = "neutral"

var current_jp = 0
var total_jp = 0
var last_score
var last_bonus_1
var just_juggling = false

var house_level = load("res://scenes/house_level/house.tscn")
var balcony_level = preload("res://scenes/balcony_scene/balcony_scene.tscn")
var juggle_level = load("res://scenes/juggling_level/juggling_scene.tscn")
var results_scr = load("res://scenes/ui_scenes/ResultsScreenUI.tscn")
var help_scr = load("res://scenes/ui_scenes/HelpScreen.tscn")
var save_scr = load("res://scenes/ui_scenes/SaveMenu.tscn")

var house_position
var in_costume = false

func calculate_mood():
	#use total JP / potential JP to figure out mood
	pass

func increment_time():
	#if the time is morning change it to evening, if its not morning make it morning
	print(time," ",day)
	if time.contains("morning"):
		time = "evening"
	else:
		time = "morning"
		increment_day()

func increment_day():
	day += 1

func update_scores(to_add):
	total_jp += to_add
	current_jp += to_add

func open_juggling(pos):
	house_position = pos
	print("house pos ", house_position)
	get_tree().change_scene_to_packed(juggle_level)
	just_juggling = true

func open_balcony():
	var balc = balcony_level.instantiate()
	balc.position = Vector2(-10000,-10000)
	get_tree().root.add_child(balc)
	TextManager.tb = balc.get_node("text_ui/Control")

func open_house(juggle_score,items_left):
	#increment_time()
	last_score = juggle_score
	last_bonus_1 = items_left * 10
	update_scores(last_score)
	update_scores(last_bonus_1)
	get_tree().change_scene_to_packed(house_level)

func open_save_menu(pos) -> void:
	house_position = pos
	get_tree().change_scene_to_packed(save_scr)
	print("house pos ", house_position)
