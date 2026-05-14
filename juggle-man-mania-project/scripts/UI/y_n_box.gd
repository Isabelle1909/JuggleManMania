extends Control

@onready var no = $Panel/no_button
@onready var yes = $Panel/yes_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	no.grab_focus.call_deferred()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
