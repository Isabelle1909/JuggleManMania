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
var juggle_level = load("res://scenes/juggling_level/juggling_scene.tscn")
var tutorial_level = load("res://scenes/juggling_level/tutorial/tutorial_scene.tscn")
var tutorial_menu = load("res://scenes/juggling_level/tutorial/tutorial_menu.tscn")
var results_scr = load("res://scenes/ui_scenes/ResultsScreenUI.tscn")
var help_scr = load("res://scenes/ui_scenes/HelpScreen.tscn")
var save_scr = load("res://scenes/ui_scenes/SaveMenu.tscn")

var house_position
var balc_position
var current_position
var location = "house"
var in_costume = false
var tutorial_done = false

var go_balc = false
var leave_balc = false

var tutorial_max = 0
var infinity_max = 0

var new_high_score_text = "you got a new high score!"
var normal_completion_text = "you completed the tutorial you champ, you."


var default_talked_to_nums = {
	"wardrobe": 0,
	"mirror": 0,
	"bed": 0,
	"computer": 0,
	"tutorial": 0
}

var default_talked_cutscene_nums = {
	"-1": 2,
	"0": 1,
	"1": 1,
	"2": 2,
	"3": 1,
	"4": 1,
	"undress": 0,
	"dress": 0,
	"stay": 0,
	"smoke": 0,
	"dress_practice":0
	
}



func calculate_mood():
	#use total JP / potential JP to figure out mood
	var percent = total_jp / (day * 50.0)
	if percent > 1:
		mood = "good"
	elif percent < 0.5:
		mood = "bad"
	else:
		mood = "neutral"

func increment_time():
	#if the time is morning change it to evening, if its not morning make it morning
	print(time," ",day)
	TextManager.talked_to_nums.assign(default_talked_to_nums)
	TextManager.talked_cutscene_nums.assign(default_talked_cutscene_nums)
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

func open_tutorial():
	get_tree().change_scene_to_packed(tutorial_level)

func open_house(juggle_score,items_left):
	if SystemManager.location.contains("house"):
		current_position = house_position
	else:
		current_position = balc_position
	#increment_time()
	last_score = juggle_score
	last_bonus_1 = items_left * 10
	update_scores(last_score)
	update_scores(last_bonus_1)
	get_tree().change_scene_to_packed(house_level)

func open_tutorial_menu(pos):
	if pos != null:
		balc_position = pos
	get_tree().change_scene_to_packed(tutorial_menu)


func open_save_menu(pos) -> void:
	if SystemManager.location.contains("balc"):
		balc_position = pos
	else:
		house_position = pos
	get_tree().change_scene_to_packed(save_scr)
	
