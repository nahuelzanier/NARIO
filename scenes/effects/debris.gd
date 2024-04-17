extends Node2D

@onready var debris_nw = $DebrisNW
@onready var debris_ne = $DebrisNE
@onready var debris_sw = $DebrisSW
@onready var debris_se = $DebrisSE


func _ready():
	$AnimationPlayer.play("block_destruction", -1, 1)

func _on_animation_player_animation_finished(anim_name):
	queue_free()

func _on_rotation_timeout():
	debris_nw.rotate(PI/2)
	debris_ne.rotate(PI/2)
	debris_sw.rotate(PI/2)
	debris_se.rotate(PI/2)
