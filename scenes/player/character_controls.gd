extends CharacterBody2D

const COLLISION_POLYGON_SMALL_PLAYER = preload("res://scenes/player/collision_polygon_small_player.tscn")
const COLLISION_POLYGON_BIG_PLAYER = preload("res://scenes/player/collision_polygon_big_player.tscn")

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_polygon_2d = $CollisionPolygon2D

var ducking = false
var can_stand_up = 0
var is_big

const max_speed = 110
const max_run_speed = 190

const speed_coef = 170
const run_speed_coef = 390

const jummp_base = 73
const jump_speed_coef = 77
var jump_reducer = 1

var dir = 0.0
var last_dir = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if is_on_floor():
		jump_reducer = 1
		duck()
	falling(delta)
	jump()
	var dir = Input.get_axis("left", "right")
	if ducking:
		if last_dir == dir and not is_on_floor():
			air_move(dir, delta)
		else:
			reduce_velocity(dir, delta)
	if not ducking:
		if last_dir == dir:
			if is_on_floor():
				ground_move(dir, delta)
			elif not is_on_floor():
				air_move(dir, delta)
		else:
			reduce_velocity(dir, delta)
	if velocity.x==0 and is_on_floor() and not ducking:
		animation_player.play("idle")
	if dir != 0:
		sprite_2d.flip_h = bool(last_dir>0)
	move_and_slide()

#AUX_PROCESS
func duck():
	if is_big:
		if Input.is_action_pressed("down"):
			ducking = true
			animation_player.play("duck")
			collision_polygon_2d.queue_free()
			collision_polygon_2d = COLLISION_POLYGON_SMALL_PLAYER.instantiate()
			add_child(collision_polygon_2d)
		elif can_stand_up==0:
			ducking = false
			collision_polygon_2d.queue_free()
			collision_polygon_2d = COLLISION_POLYGON_BIG_PLAYER.instantiate()
			add_child(collision_polygon_2d)

func falling(delta):
	if not is_on_floor() and velocity.y<400:
		if not ducking:
			if velocity.y < 0:
				animation_player.play("jump")
			else:
				animation_player.play("falling")
		velocity.y += gravity * delta

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = - jummp_base - abs(velocity.x)/67
	if Input.is_action_pressed("jump") and velocity.y < 0:
		velocity.y -= jump_speed_coef/jump_reducer + abs(velocity.x) / 112
		jump_reducer += 1

func reduce_velocity(dir, delta):
	if velocity.x * last_dir > 0:
		if is_on_floor() and abs(velocity.x)>max_speed and not ducking:
			animation_player.play("breaking")
		velocity.x -= last_dir * run_speed_coef * 1.2 * delta
	else:
		velocity.x = 0
		last_dir = dir

func air_move(dir, delta):
	if velocity.x * dir < max_speed:
		velocity.x += dir * speed_coef * delta
		last_dir = dir

func ground_move(dir, delta):
	if Input.is_action_pressed("run"):
		animation_player.play("walk", -1, 1.7)
		if velocity.x * dir < max_run_speed:
			velocity.x += dir * run_speed_coef * delta
			last_dir = dir
	else:
		animation_player.play("walk")
		if velocity.x * dir < max_speed:
			velocity.x += dir * speed_coef * delta
			last_dir = dir
		else:
			velocity.x -= last_dir * run_speed_coef * delta  #STOP RUNNING
