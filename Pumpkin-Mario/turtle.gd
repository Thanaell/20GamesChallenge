extends Enemy

const up_collider_position: Vector2 = Vector2(9.0, 31.0)
const down_collider_position: Vector2 = Vector2(-6.0, 39.0)

var is_up: bool = true
var should_stop: bool = false

@onready var turtle_stomp_area: Area2D = $stompTurtleArea


func _ready():
	$AnimatedSprite2D.play("up")
	turtle_stomp_area.position = up_collider_position


func on_kill_player_entered(body: Node2D):
	if is_up:
		Character.on_kill_player_collision()
	else:
		if direction != 0.0:
			Character.on_kill_player_collision()
		else:
			$AnimatedSprite2D.play("down_moving")
			if body.position.x - position.x > 0:
				direction = -1
			else:
				direction = 1


func on_kill_enemy_entered(_area : Area2D):
	Character.on_bounce()
	if is_up:
		is_up = false
		$AnimatedSprite2D.play("down_idle")
		turtle_stomp_area.position = down_collider_position
		direction = 0
	else:
		if direction == 0:
			queue_free()
		else:
			$AnimatedSprite2D.play("down_idle")
			direction = 0
