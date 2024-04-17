extends "res://scenes/blocks/_block_abstract.gd"

const DEBRIS = preload("res://scenes/effects/debris.tscn")

func player_punch(player):
	if Global.player.is_big:
		$AnimationPlayer.play("punched_big", 1, 1.5)
		player.velocity.y = 50
		z_index = 1
	else:
		$AnimationPlayer.play("punched")
		player.velocity.y = 50
		z_index = 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "punched_big":
		var debris = DEBRIS.instantiate()
		debris.position = position
		Global.level.add_child(debris)
		queue_free()
	if anim_name == "punched":
			z_index = 0
