extends Node2D





func _physics_process(delta: float) -> void:
	#when morning is active. dosent appear
	if SystemManager.time.contains("evening"):
		visible = true
		print("cant be night when its day")
	else:
		visible = false
		print("cant be night when its day")
		
		print("this works")
