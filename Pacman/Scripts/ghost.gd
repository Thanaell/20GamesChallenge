class_name Ghost extends Area2D

var speed: float = 100.0
var path: PackedVector2Array = PackedVector2Array()

@onready var pacman: Area2D = $"../pacman"
@onready var tile_map: Pathfinder = $"../level"


func _process(delta):
	if len(path) < 2:
		path = chose_path()
	else:
		var direction: Vector2 = (path[1] - position).normalized()
		position += delta * speed * direction
		var is_arrived: bool = (path[1] - position).dot(direction) < 0
		if is_arrived:
			position = path[1]
			path.remove_at(1)


func chose_path() -> PackedVector2Array:
	print("This is an abstract function that should not be called")
	return PackedVector2Array()


func on_timeout():
	path = chose_path()
