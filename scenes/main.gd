extends Node2D

@onready var level = $Level
@onready var preload_scenes = $PreloadScenes

func _ready():
	Global.level = level
	
	var elements = $PreloadScenes/TileMap.get_elements()
	for v2 in elements.keys():
		var new_elem = preload_scenes.tiles[elements[v2]].instantiate()
		new_elem.position = v2 * Global.block_size
		level.add_child(new_elem)
