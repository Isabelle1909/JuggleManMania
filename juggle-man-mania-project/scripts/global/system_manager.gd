extends Node

var time = "morning"
var day = "1"
var mood = "neutral"
var current_jp = 0
var total_jp = 0
var juggleMan = preload("res://scenes/juggling_scene.tscn")


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


func inst(pos):
	var instance = juggleMan.instantiate()
	#instance.position = pos
	return(instance)
