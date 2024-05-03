class_name Pathfinder extends TileMap

const tile_size: int = 16
const tile_map_x: int = 19
const tile_map_y: int = 18

var a_star = AStarGrid2D.new()
var dot = preload("res://dot.tscn")
var star = preload("res://star.tscn")
func _ready():
	a_star.region = Rect2i(0, 0, tile_map_x, tile_map_y)
	a_star.cell_size = Vector2(tile_size, tile_size)
	a_star.offset = 0.5 * Vector2(tile_size, tile_size)
	a_star.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	a_star.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	a_star.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	a_star.update()

	for i in range(a_star.region.position.x, a_star.region.end.x):
		for j in range(a_star.region.position.y, a_star.region.end.y):
			var pos = Vector2i(i, j)
			var tile_data: TileData = get_cell_tile_data(0, pos)
			if !tile_data.get_custom_data("is_traversable"):
				a_star.set_point_solid(pos)
			elif tile_data.get_custom_data("is_dottable")  :
				var new_dot = dot.instantiate()
				new_dot.position=map_to_local(pos)
				add_child(new_dot)	
			else : 
				var new_star = star.instantiate()
				new_star.position=map_to_local(pos)
				add_child(new_star)	


func is_tile_traversable(source_coord: Vector2, direction: Vector2) -> bool:
	var target_map_index: Vector2i = local_to_map(source_coord + (tile_size * direction))
	var tile_data: TileData = get_cell_tile_data(0, target_map_index)
	return tile_data.get_custom_data("is_traversable")


func find_path(source_coord: Vector2, target_coord: Vector2) -> PackedVector2Array:
	var source_point: Vector2i = local_to_map(source_coord)
	var target_point: Vector2i = local_to_map(target_coord)
	return a_star.get_point_path(source_point, target_point)


func find_path_with_direction(source_coord: Vector2, direction: Vector2) -> PackedVector2Array:
	return find_path(source_coord, source_coord + (tile_size * direction))
