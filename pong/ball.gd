extends Area2D

signal paddleHit
var rotation_speed = PI
var speed = 500
var init_speed=400
var speed_increment=10
var velocity=Vector2.ZERO

func _ready():
	_reset_position()
	
func _physics_process(delta):
	position+=delta*velocity
	rotation+=delta*rotation_speed
	speed+=delta*speed_increment
	

func bounce(isWallBounce:bool):
	if (isWallBounce):
		velocity.y=-velocity.y
	else:
		var previousVelocityX=velocity.x
		_randomize_direction()
		if (velocity.x<0 && previousVelocityX<0 || velocity.x>0 && previousVelocityX>0):
			velocity.x=-velocity.x

func _randomize_direction():
	var rng = RandomNumberGenerator.new()
	var random_x = (rng.randi_range(0,1) * 2) - 1
	var random_y = rng.randf_range(-0.5, 0.5)
	velocity = speed * Vector2(random_x,random_y)

func _reset_position():
	speed=init_speed
	position=get_viewport_rect().size / 2
	_randomize_direction()
	

func _on_area_entered(area):
	if area.is_in_group("walls"):
		bounce(true)
	elif area.is_in_group("paddles"):
		bounce(false)
		paddleHit.emit()
	else:
		_reset_position()
