extends Node2D

var small_asteroid = preload("res://asteroid_small.tscn")
var medium_asteroid = preload("res://asteroid_medium.tscn")
var large_asteroid = preload("res://asteroid_large.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func  create_asteroid():
	var rng = RandomNumberGenerator.new()
	var i = rng.randi_range(0,8)
	var asteroid : Asteroid 
	match i :
		0:
			asteroid=large_asteroid.instantiate()
		1:		
			asteroid=medium_asteroid.instantiate()
		2:
			asteroid=small_asteroid.instantiate()
		_:
			return
	add_child(asteroid)
	var randX = rng.randi_range(0,1)
	var randY = rng.randi_range(0,1)
	asteroid.position=Vector2(randX*get_viewport_rect().size.x, randY*get_viewport_rect().size.y)

	asteroid.set_random_direction_target((Vector2(get_viewport_rect().size / 2) - asteroid.position).normalized())

	asteroid.set_random_speed()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
