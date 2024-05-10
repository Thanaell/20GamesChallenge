extends Enemy

const up_collider_position: Vector2 = Vector2(9.0, 31.0)
const down_collider_position: Vector2 = Vector2(-6.0, 39.0)
const speed_factor: float = 500.0

var is_up: bool = true
var should_stop: bool = false
var velocity_factor: float = 0.0

@onready var turtle_stomp_area: Area2D = $stompTurtleArea


func _ready():
	$AnimatedSprite2D.play("up")
	turtle_stomp_area.position = up_collider_position


func _integrate_forces(_state):
	angular_velocity = 0.0
	if should_stop:
		should_stop = false
		linear_velocity = Vector2(0.0, 0.0)
	if abs(velocity_factor) > 0.01:
		linear_velocity.x = velocity_factor * speed_factor 
		velocity_factor = 0.0


func handle_player_collision(force_to_apply: Vector2 = Vector2(0.0, 0.0)) -> bool:
	if is_up:
		return true
	else:
		if abs(linear_velocity.x) > 0.01:
			return true
		else:
			velocity_factor = force_to_apply.x
			return false


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


func on_body_entered(body: Node):
	print("enter body " + body.name)
	var collision_normal: Vector2 = position - body.position
	if !is_up && abs(Vector2.UP.dot(collision_normal)) < 0.3:
		linear_velocity.x = collision_normal.x * speed_factor
