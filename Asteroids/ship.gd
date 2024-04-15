extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var is_moving=false
var animation_time = 1.0
var throttle_force=500.0
var torque_force=2000.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	reset_animation()
	
func reset_animation():
	$AnimatedSprite2D.play("throttle_off")

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		is_moving=true
		apply_torque(-torque_force)
	if Input.is_action_pressed("ui_right"):
		is_moving=true
		apply_torque(torque_force)
	if Input.is_action_pressed("ui_up"):
		is_moving=true
		apply_central_force(throttle_force*get_global_transform().basis_xform(Vector2.RIGHT))
	
	
	if Input.is_action_just_pressed("ui_accept"):
		pass
	if is_moving : 
		$AnimatedSprite2D.play("throttle_on")
		$Timer.start(animation_time)
		is_moving=false
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
