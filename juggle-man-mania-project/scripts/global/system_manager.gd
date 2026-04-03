extends Node

var time = "morning"
var day = "1"
var mood = "neutral"
var current_jp = 0
var total_jp = 0
var juggleMan = load("res://scenes/juggling_level/juggling_scene.tscn")
var results_scr = load("res://scenes/ui_scenes/ResultsScreenUI.tscn")
var help_scr = load("res://scenes/ui_scenes/HelpScreen.tscn")

func calculate_mood():
	#use total JP / potential JP to figure out mood
	pass

func increment_time():
	#if the time is morning change it to evening, if its not morning make it morning
	if time.contains("morning"):
		time = "evening"
	else:
		time = "morning"

func increment_day():
	day += 1

func update_scores(to_add):
	total_jp += to_add
	current_jp += to_add

func instj():
	var instance = juggleMan.instantiate()
	return(instance)

func instr():
	var instance = results_scr.instantiate()
	return(instance)
