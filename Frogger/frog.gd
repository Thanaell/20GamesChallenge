extends Node2D

@export var lerp_speed: float = 10.0

var is_moving_vertical: bool = false
var is_moving_horizontal: bool = false

var x_target: float = 0.0
var y_target: float = 0.0

var lerp_progression=0

func _process(delta):
	if is_moving_vertical:
		lerp_progression+=delta*lerp_speed
		position=position.lerp(Vector2(position.x, y_target), lerp_progression)
		print(lerp_progression)
		if (lerp_progression>=1.0):
			lerp_progression=0.0
			is_moving_vertical=false

func vertical_lerp_to_position(y: float):
	is_moving_vertical = true
	y_target = y
	lerp_progression = 0
