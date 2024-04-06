extends AbstractObstacle

var cos_range = 0.8
var value
# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	value = randf_range(0,PI)
	speed=200 # Replace with function body.
	

func _process(delta):
	super._process(delta)
	position.y+=cos_range*cos(value+position.x/100)


