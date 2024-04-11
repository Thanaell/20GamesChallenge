class_name Turtle extends Block

var time_up : float = 5.0
var time_down : float = 5.0

var hasFrog = false;
signal dived_with_frog
var isUp = true

func removeFrog():
	hasFrog=false

func _ready():	
	blockType=BlockType.TURTLE
	
	#connect to broadcast handler
	dived_with_frog.connect(BroadcastEventsHandler.on_turtle_dive_with_frog)
	
	$AnimatedSprite2D.play("up")
	
	var rng = RandomNumberGenerator.new()
	var startTime = rng.randf_range(1,5)
	$StartTimer.start(startTime)

func go_down_water():
	$AnimatedSprite2D.play("go_down_water")

func go_up_water():
	$AnimatedSprite2D.play("go_up_water")

func on_anim_finished():
	if (isUp):
		isKill=false
		$AnimatedSprite2D.play("up")
	else :
		if (hasFrog):
			dived_with_frog.emit()
		isKill=true
		$AnimatedSprite2D.play("down")

func handleTimer():
	if (isUp):
		go_down_water()
		$StartTimer.start(time_down)
	else :
		go_up_water()
		$StartTimer.start(time_up)
	isUp=!isUp
