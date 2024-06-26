class_name Ghost extends Area2D

const normal_speed: float = 90.0
const revenge_speed: float = 65.0

var speed: float = 90.0
var path: PackedVector2Array = PackedVector2Array()
var game_state = GameController.GAME_STATE.NORMAL

@export var spawn_position: Vector2

@onready var pacman: Pacman = $"../pacman"
@onready var tile_map: Pathfinder = $"../level"


func _ready():
	reset()


func _process(delta):
	if len(path) < 2:
		if game_state == GameController.GAME_STATE.NORMAL:
			path = choose_path()
		else:
			path = choose_revenge_path()
	else:
		var direction: Vector2 = (path[1] - position).normalized()
		update_sprite(direction)
		position += delta * speed * direction
		var is_arrived: bool = (path[1] - position).dot(direction) < 0
		if is_arrived:
			position = path[1]
			path.remove_at(1)
			if tile_map.get_traversable_neighbours_number(position) > 2:
				if game_state == GameController.GAME_STATE.NORMAL:
					path = choose_path()
				else:
					path = choose_revenge_path()


func update_sprite(direction: Vector2 = Vector2(0,0)):
	var sprite: AnimatedSprite2D = $AnimatedSprite2D
	if(game_state==GameController.GAME_STATE.REVENGE):
		sprite.play("revenge")
	else:
		if direction.x > 0: sprite.play("right")
		elif direction.y > 0: sprite.play("down")
		elif direction.x < 0: sprite.play("left")
		elif direction.y < 0: sprite.play("up")


func choose_path() -> PackedVector2Array:
	print("This is an abstract function that should not be called")
	return PackedVector2Array()


func choose_revenge_path() -> PackedVector2Array:
	return tile_map.find_path(position, spawn_position)


func change_state(new_game_state):
	game_state = new_game_state
	if game_state == GameController.GAME_STATE.NORMAL:
		speed = normal_speed
		path.clear()
	else:
		speed = revenge_speed
		path.clear()
	update_sprite()


func reset():
	position = spawn_position
	path.clear()
