extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

const SPEED = 30

var direction = 1

var stomped = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_player.play("walk")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if velocity.x == 0:
		direction = direction * (-1)

	velocity.x = direction * SPEED

	move_and_slide()

func player_punch(player): pass

func player_stomp(player):
	call_deferred("disabe_player_collision")
	animation_player.play("stomped")
	if not stomped:
		Global.player.velocity.y = -70
		stomped = true

func player_body_contact(player): pass
func player_body_uncontact(player): pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "stomped":
		queue_free()

func disabe_player_collision():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
