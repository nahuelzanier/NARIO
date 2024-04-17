extends "res://scenes/player/character_controls.gd"

func _ready():
	is_big = false
	Global.player = self

func _on_head_punch_body_entered(body):
	body.player_punch(self)

func _on_foot_stomp_body_entered(body):
	body.player_stomp(self)

func _on_body_area_body_entered(body):
	body.call_deferred("player_body_contact",self)
