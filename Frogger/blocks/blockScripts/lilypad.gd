class_name LilyPad extends Block

func _ready():
	blockType=BlockType.LILYPAD
	$AnimatedSprite2D.play("default")

func fill(area : Area2D):
	$AnimatedSprite2D.play("win_lilypad")
