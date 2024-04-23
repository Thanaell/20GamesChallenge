class_name Asteroid extends Area2D
enum Size {SMALL, MEDIUM, LARGE}

@export var size : Size = Size.LARGE
var speed = 30.0
var direction = Vector2(0,1)

var asteroid_despawn_offset = 50.0
var shouldDestroy=false
var small_asteroid = preload("res://asteroid_small.tscn")
var medium_asteroid = preload("res://asteroid_medium.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_direction()
	set_random_speed()

func set_random_speed():
	var rng = RandomNumberGenerator.new()
	speed = rng.randf_range(20,100)
	
func set_random_direction():
	var rng = RandomNumberGenerator.new()
	var random_x = rng.randf_range(0,1)
	var random_y = rng.randf_range(0,1)
	direction=Vector2(random_x,random_y)

func set_random_direction_target(main_target : Vector2):
	var rng = RandomNumberGenerator.new()
	var rand_angle = rng.randf_range(-PI/4,PI/4)
	direction=Vector2(cos(rand_angle)*main_target.x,sin(rand_angle)*main_target.y)
	
	
func on_hit():
	match size:
		Size.MEDIUM:
			for i in range (0,3):
				var new_small_asteroid = small_asteroid.instantiate()
				new_small_asteroid.position=get_global_transform().origin	
				get_parent().add_child.bind(new_small_asteroid).call_deferred()
		Size.LARGE:
			for i in range (0,2):
				var new_medium_asteroid = medium_asteroid.instantiate()
				new_medium_asteroid.position=get_global_transform().origin
				get_parent().add_child.bind(new_medium_asteroid).call_deferred()
	shouldDestroy=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x < -asteroid_despawn_offset):
		shouldDestroy = true
	if (position.x > get_viewport_rect().size.x + asteroid_despawn_offset):
		shouldDestroy = true
	if (position.y < -asteroid_despawn_offset):
		shouldDestroy = true
	if (position.y >get_viewport_rect().size.y + asteroid_despawn_offset):
		shouldDestroy = true
	if(shouldDestroy):
		queue_free()
	position+=delta*speed*direction
	
