extends Area2D

var baseMoveSpeedUp = 500.0
var baseMoveSpeedDown = 300.0

const upSprite = preload("res://Assets/dragon-joyride1.png")
const downSprite = preload("res://Assets/dragon-joyride2.png") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		position-=Vector2(0,baseMoveSpeedUp*delta)
		$Sprite2D.set_texture(upSprite)
		
	else :
		position+=Vector2(0,baseMoveSpeedDown*delta)
		$Sprite2D.set_texture(downSprite)
	position.y = clamp(position.y,0,get_viewport_rect().size.y)


