class_name Ship extends RigidBody2D

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

signal crashed

func _ready():
	reset_animation()

func reset_animation():
	$AnimatedSprite2D.play("throttle_off")

func _integrate_forces(_state):
	if (position.x < -ship_size):
		position.x = get_viewport_rect().size.x
	if (position.x > get_viewport_rect().size.x + ship_size):
		position.x = 0
	if (position.y < -ship_size):
		position.y = get_viewport_rect().size.y
	if (position.y >get_viewport_rect().size.y + ship_size):
		position.y = 0

	# Good practices would be to implement inputs outside of the RigidBody2D
	# script because they will be ignored when the RigidBody2D goes asleep
	#
	# The "can_sleep" was toggled off to prevent this
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
		bullet.position=$BulletSpawn.get_global_transform().get_origin()
		get_tree().root.add_child.bind(bullet).call_deferred()
	if is_moving : 
		$AnimatedSprite2D.play("throttle_on")
		$Timer.start(animation_time)
		is_moving=false


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main_scene.tscn")

func ship_crashed():
	crashed.emit()
