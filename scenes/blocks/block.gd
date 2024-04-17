extends "res://scenes/blocks/_block_abstract.gd"

func player_punch(player):
	$AnimationPlayer.play("punched")
	player.velocity.y = 50
	z_index = 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "punched":
		z_index = 0
