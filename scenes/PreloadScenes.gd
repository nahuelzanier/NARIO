extends Node

#TAGS
var block = &"block"

#EFFECTS
const DEBRIS = preload("res://scenes/effects/debris.tscn")

#PRELOAD
const BLOCK = preload("res://scenes/blocks/block.tscn")
const ENEMY_01 = preload("res://scenes/enemies/enemy_01.tscn")
const USED_BLOCK = preload("res://scenes/blocks/used_block.tscn")
const BLOCK_POWER_UP_01 = preload("res://scenes/blocks/block_power_up_01.tscn")
const POWER_UP_01 = preload("res://scenes/power_ups/power_up_01.tscn")

#TILES
var tiles = [
	BLOCK,
	ENEMY_01,
	USED_BLOCK,
	BLOCK_POWER_UP_01,
	POWER_UP_01
]

const PLAYER_SMALL = preload("res://scenes/player/player_small.tscn")
const PLAYER_BIG = preload("res://scenes/player/player_big.tscn")

func _ready():
	Global.preloads = self
