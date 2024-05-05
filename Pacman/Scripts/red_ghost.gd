extends Ghost


func choose_path() -> PackedVector2Array:
	return tile_map.find_path(position, pacman.position)
