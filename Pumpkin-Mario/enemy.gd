class_name Enemy extends Area2D

var direction: int = -1

@export var speed: float = 300.0

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight


func _process(delta):
	if ray_cast_left.is_colliding() && direction != 0:
		direction = 1
	if ray_cast_right.is_colliding() && direction != 0:
		direction = -1
	
	position.x += direction * speed * delta
	if direction>0 : $AnimatedSprite2D.scale.x=-1
	elif direction<0 : $AnimatedSprite2D.scale.x=1


func on_kill_player_entered(_body: Node2D):
	Character.on_kill_player_collision()


func on_kill_enemy_entered(_area : Area2D):
	Character.on_bounce()
	queue_free()
