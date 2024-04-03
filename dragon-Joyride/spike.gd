extends AbstractObstacle

# Called when the node enters the scene tree for the first time.
func _ready():
	speed=80 # Replace with function body.


#not putting it in has the same result as putting super
func _process(delta):
	super._process(delta)
