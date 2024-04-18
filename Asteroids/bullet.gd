extends Area2D

var direction : Vector2
const speed = 500.0

func set_direction(new_direction : Vector2):
	direction=new_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=delta*speed*direction

func on_asteroid_hit(area : Area2D):
	if area is Asteroid:
		area.on_hit()
		queue_free()

