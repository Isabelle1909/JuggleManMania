extends Node2D

@onready var night_image = $Evening_placeholder

var evening = true
var visible = false


func toggle_evening():
	#when morning is active. dosent appear
	if Time == evening:
		visible = true
		print("cant be night when its day")
	else:
		visible = false
		print("cant be night when its day")
		
		print("this works")
