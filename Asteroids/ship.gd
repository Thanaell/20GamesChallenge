extends RigidBody2D

var bullet_scene = preload("res://bullet.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var is_moving=false
var animation_time = 1.0
var throttle_force=500.0
var torque_force=2000.0

const ship_size = 15.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	reset_animation()
	
func reset_animation():
	$AnimatedSprite2D.play("throttle_off")

func _integrate_forces(state):
	if (position.x < -ship_size):
		position.x = get_viewport_rect().size.x
	if (position.x > get_viewport_rect().size.x + ship_size):
		position.x = 0
	if (position.y < -ship_size):
		position.y = get_viewport_rect().size.y
	if (position.y >get_viewport_rect().size.y + ship_size):
		position.y = 0
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
		var bullet = bullet_scene.instantiate()
		bullet.set_direction(get_global_transform().basis_xform(Vector2.RIGHT))
		get_tree().root.add_child(bullet)
		bullet.position=$BulletSpawn.get_global_transform().get_origin()
	if is_moving : 
		$AnimatedSprite2D.play("throttle_on")
		$Timer.start(animation_time)
		is_moving=false
	
