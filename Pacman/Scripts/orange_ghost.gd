extends Ghost


func choose_path() -> PackedVector2Array:
	var path_to_pacman: PackedVector2Array = tile_map.find_path(position, pacman.position)
	if len(path_to_pacman) < 9:
		return tile_map.find_path(position, spawn_position)
	return path_to_pacman
