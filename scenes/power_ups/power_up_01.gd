extends CharacterBody2D

var moving = false
var speed = 50
var direction

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	direction = [-1, 1].pick_random()
	$AnimationPlayer.play("rise")

func _physics_process(delta):
	if moving:
		if not is_on_floor():
			velocity.y += gravity * delta
		if velocity.x == 0:
			direction = direction * (-1)
		velocity.x = direction * speed
	move_and_slide()

func player_punch(player): pass

func player_stomp(player): pass

func player_body_contact(player):
	if not player.is_big:
		var new_player = Global.preloads.PLAYER_BIG.instantiate()
		new_player.position = player.position
		player.queue_free()
		Global.level.add_child(new_player)
		queue_free()

func player_body_uncontact(player): pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "rise":
		moving = true
