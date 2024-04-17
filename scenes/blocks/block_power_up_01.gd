extends "res://scenes/blocks/_block_abstract.gd"

func player_punch(player):
	$AnimationPlayer.play("punched")
	player.velocity.y = 50
	z_index = 1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "punched":
		z_index = 0
	var new_block = Global.preloads.USED_BLOCK.instantiate()
	new_block.position = position
	Global.level.add_child(new_block)
	var new_power_up = Global.preloads.POWER_UP_01.instantiate()
	new_power_up.position = position - Vector2(0, 16)
	Global.level.add_child(new_power_up)
	queue_free()
