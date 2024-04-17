extends "res://scenes/player/character_controls.gd"

func _ready():
	is_big = true
	Global.player = self

func _on_head_punch_body_entered(body):
	if not block_punched:
		block_punched = true
		body.player_punch(self)

func _on_foot_stomp_body_entered(body):
	body.player_stomp(self)

func _on_body_area_body_entered(body):
	body.call_deferred("player_body_contact",self)

func _on_body_area_body_exited(body):
	body.player_body_uncontact(self)

func _on_duck_check_body_entered(body):
	body.duck_player_body_contact(self)

func _on_duck_check_body_exited(body):
	body.duck_player_body_uncontact(self)
