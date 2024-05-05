extends Ghost

@onready var red_ghost: Area2D = $"../red_ghost"


func chose_path() -> PackedVector2Array:
	# Locate the tile 2 tiles in front of pacman
	var temp_position: Vector2 = tile_map.find_position_in_front(pacman.position, pacman.direction, 2)
	# The target tile is the position of the red_ghost
	# Adding 2 times the vector between red_ghost and temp_position
	var target_position: Vector2 = red_ghost.position + 2 * (temp_position - red_ghost.position)
	# Making sure we don't target outside the tilemap
	var corrected_target_position: Vector2 = tile_map.find_position_in_front(target_position, Vector2(0, 0), 0)
	return tile_map.find_path(position, corrected_target_position)
