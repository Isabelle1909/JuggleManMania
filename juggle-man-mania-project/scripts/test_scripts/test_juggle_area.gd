extends Node2D



var ball_impulse_1 = Vector2(0.0,-500.0)

var in_A1 = []
var in_A2 = []
var in_A3 = []

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("test input 1"):
		apply_to_all()

func apply_to_all():
	#applies impulse to everything in range when button is pressed
	for i in range(in_A1.size()):
		var ob = in_A1[i]
		ob.apply_impulse(ball_impulse_1,global_position)
		print("Hi-yah!")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		print("balli")
		in_A1.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name.contains("ball"):
		print("ballo")
		in_A1.erase(body)




func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		print("balli")
		in_A1.append(body)
	
	


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	pass # Replace with function body.




func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name.contains("ball"):
		print("balli")
		in_A1.append(body)
	




func _on_area_2d_3_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
