extends RigidBody2D

const up_collider_position: Vector2 = Vector2(9.0, 31.0)
const down_collider_position: Vector2 = Vector2(-6.0, 39.0)

var is_up: bool = true
var should_stop: bool = false

@onready var turtle_stomp_area: Area2D = $stompTurtleArea


func _ready():
	$AnimatedSprite2D.play("up")
	turtle_stomp_area.position = up_collider_position


func _integrate_forces(_state):
	if should_stop:
		should_stop = false
		linear_velocity = Vector2(0.0, 0.0)


func on_stomp_turtle(_area: Area2D):
	Character.on_bounce()
	if is_up:
		is_up = false
		$AnimatedSprite2D.play("down")
		turtle_stomp_area.position = down_collider_position
	else:
		if linear_velocity.x <= 0.01:
			queue_free()
		else:
			should_stop = true
