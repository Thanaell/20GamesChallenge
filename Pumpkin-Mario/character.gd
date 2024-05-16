extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const SPAWN_POSITION: Vector2 = Vector2(98.0, 444.0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var should_bounce: bool = false


func _ready():
	$AnimatedSprite2D.play("idle")
	position = SPAWN_POSITION


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("jumping")
		velocity.y += gravity * delta
	else :
		$AnimatedSprite2D.play("running")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if should_bounce:
		should_bounce = false
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x>=0 : $AnimatedSprite2D.scale.x=1
	else : $AnimatedSprite2D.scale.x=-1
	if velocity.x<=0.01 && is_on_floor() : $AnimatedSprite2D.play("idle")
	move_and_slide()


func on_kill_player_collision():
	position = SPAWN_POSITION


func on_bounce():
	should_bounce = true
