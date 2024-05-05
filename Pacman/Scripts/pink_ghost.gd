extends Ghost


func choose_path() -> PackedVector2Array:
	var target_position: Vector2 = tile_map.find_position_in_front(pacman.position, pacman.direction, 4)
	return tile_map.find_path(position, target_position)
