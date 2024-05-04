extends Ghost


func chose_path() -> PackedVector2Array:
	var new_path: PackedVector2Array = tile_map.find_path(position, pacman.position)
	return new_path
