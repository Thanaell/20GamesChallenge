extends Node2D

var moveDelta=3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rightPaddle = $PaddleRight
	var leftPaddle = $PaddleLeft
	print (-get_viewport_rect().size.y/2)
	print (get_viewport_rect().size.y/2)
	if Input.is_action_pressed("left_paddle_up"):
		leftPaddle.position+=Vector2(0,-moveDelta)
	if Input.is_action_pressed("left_paddle_down"):
		leftPaddle.position+=Vector2(0,moveDelta)
	if Input.is_action_pressed("right_paddle_up"):
		rightPaddle.position+=Vector2(0,-moveDelta)
	if Input.is_action_pressed("right_paddle_down"):
		rightPaddle.position+=Vector2(0,moveDelta)
	print (rightPaddle.position.y)
	rightPaddle.position.y = clamp(rightPaddle.position.y,-get_viewport_rect().size.y/2,get_viewport_rect().size.y/2)
	leftPaddle.position.y = clamp(leftPaddle.position.y,-get_viewport_rect().size.y/2,get_viewport_rect().size.y/2)

func _on_ball_body_entered(body):
	pass # Replace with function body.
