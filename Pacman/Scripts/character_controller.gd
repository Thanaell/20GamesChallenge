extends Area2D

const max_speed: float = 100.0
const arrive_distance: float = 0.1

var has_speed: bool = false
var is_arrived: bool = true
var should_change_direction: bool = false
var direction: Vector2 = Vector2(0, 0)
var direction_buffer: Array = []
var path: PackedVector2Array = PackedVector2Array()

@onready var tile_map: Pathfinder = $"../level"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta):
	if Input.is_action_just_pressed("ui_right") && direction != Vector2.RIGHT:
		direction_buffer.clear()
		direction_buffer.append(Vector2.RIGHT)
	if Input.is_action_just_pressed("ui_left") && direction != Vector2.LEFT:
		direction_buffer.clear()
		direction_buffer.append(Vector2.LEFT)
	if Input.is_action_just_pressed("ui_up") && direction != Vector2.UP:
		direction_buffer.clear()
		direction_buffer.append(Vector2.UP)
	if Input.is_action_just_pressed("ui_down") && direction != Vector2.DOWN:
		direction_buffer.clear()
		direction_buffer.append(Vector2.DOWN)

	if !has_speed:
		if len(direction_buffer) > 0:
			if tile_map.is_tile_traversable(position, direction_buffer[0]):
				_update_direction()
				has_speed = true
				sprite.play("default")
				update_path()
			else:
				direction_buffer.clear()
	else:
		if len(direction_buffer) > 0:
			if tile_map.is_tile_traversable(position, direction_buffer[0]):
				should_change_direction = true

		position += delta * max_speed * direction
		is_arrived = (path[0] - position).dot(direction) < 0
		if is_arrived:
			if should_change_direction:
				_update_direction()
				should_change_direction = false
			if tile_map.is_tile_traversable(position, direction):
				update_path()
			else:
				position = path[0]
				has_speed = false
				sprite.pause()

func _update_direction():
	direction = direction_buffer.pop_front()
	if direction.y>0 : sprite.rotation = -PI/2
	elif direction.y<0: sprite.rotation = PI/2
	else: sprite.rotation=0
	if direction.x>0 : scale.x=-1
	else: scale.x = 1
	
func update_path():
	path.clear()
	path = tile_map.find_path_with_direction(position, direction)
	path.remove_at(0)
