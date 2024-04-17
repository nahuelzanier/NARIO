extends TileMap

func get_elements():
	var dict = {}
	for v2 in get_used_cells(0):
		dict[v2] = get_cell_source_id(0, v2)
	return dict
