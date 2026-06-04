extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ("morning"):
		load("res://scripts/balcony_level/morning.placeholder.jpg")
		if ("evening"):
			load("res://scripts/balcony_level/evening.placeholder.jpg")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
