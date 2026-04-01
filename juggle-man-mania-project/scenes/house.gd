extends Node2D

var inst

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("test input 1"):
		inst = SystemManager.inst(Vector2(0, 0))
		add_child(inst)
	if Input.is_action_just_pressed("test input 2"):
		if is_instance_valid(inst):
			inst.free()
