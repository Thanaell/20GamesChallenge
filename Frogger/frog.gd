extends Node2D

@export var lerp_speed: float = 5.0

signal outOfBounds

var is_moving_vertical: bool = false
var is_moving_horizontal: bool = false
var x_target: float = 0.0
var y_target: float = 0.0
var lerp_progression: float = 0.0

var speed : int = 0

func _process(delta):
	if position.x<0 || position.x > get_viewport_rect().size.x:
		outOfBounds.emit()
	if is_moving_vertical || is_moving_horizontal:
		lerp_progression += delta * lerp_speed
		position = position.lerp(Vector2(x_target, y_target), lerp_progression)
		if lerp_progression >= 1.0:
			is_moving_vertical = false
			is_moving_horizontal = false
			$AnimatedSprite2D.play("default")
	else:
		position.x+=delta*speed

func reset(resetPosition : Vector2):
	is_moving_horizontal=false
	is_moving_horizontal=false
	$AnimatedSprite2D.play("default")
	rotation=-PI/2
	position = resetPosition
	
	
	
func vertical_lerp_to_position(y: float):
	is_moving_vertical = true
	x_target = position.x
	y_target = y
	lerp_progression = 0.0
	$AnimatedSprite2D.play("jump")
	
	# Turning the sprite in the correct direction
	if position.y > y:
		look_at(position + Vector2.UP)
		rotation = fmod(rotation, 2 * PI)
	else:
		look_at(position + Vector2.DOWN)
		rotation = fmod(rotation, 2 * PI)


func horizontal_lerp_to_position(x: float):
	is_moving_horizontal = true
	x_target = x
	y_target = position.y
	lerp_progression = 0.0
	$AnimatedSprite2D.play("jump")
	
	# Turning the sprite in the correct direction
	if position.x > x:
		look_at(position + Vector2.LEFT)
		rotation = fmod(rotation, 2 * PI)
	else:
		look_at(position + Vector2.RIGHT)
		rotation = fmod(rotation, 2 * PI)
