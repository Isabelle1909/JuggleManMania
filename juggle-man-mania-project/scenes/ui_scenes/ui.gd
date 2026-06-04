extends Control

@onready var clown = $Panel/clown
@onready var normal = $Panel/normal

func _physics_process(delta: float) -> void:
	if SystemManager.in_costume == true:
		clown.visible = true
		normal.visible = false
	else:
		clown.visible =false
		normal.visible =true
	
