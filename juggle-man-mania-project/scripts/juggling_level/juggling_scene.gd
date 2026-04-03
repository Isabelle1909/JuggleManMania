extends Node2D

@onready var score_display = $score_display/RichTextLabel
@onready var player = $juggling_player


var score = 0
var timer = 10 * 60

func _physics_process(delta: float) -> void:
	if score != player.score:
		score = player.score
		update_score_display()
	

func update_score_display():
	var text = str("Score: ", score)
	score_display.text = text 



func _on_dampener_body_entered(body: Node2D) -> void:
	if body.is_in_group("juggling_object"):
		if body.is_in_group("ball"):
			body.linear_damp = 20.0
	
	


func _on_dampener_body_exited(body: Node2D) -> void:
	if body.is_in_group("juggling_object"):
		if body.is_in_group("ball"):
			body.linear_damp = 0.0
