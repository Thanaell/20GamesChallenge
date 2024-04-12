class_name LilyPad extends Block

var isChecked = false
signal lilypad_checked
func _ready():
	blockType=BlockType.LILYPAD
	lilypad_checked.connect(BroadcastEventsHandler.on_lilypad_checked)
	$AnimatedSprite2D.play("default")

func fill(_area : Area2D):
	if (!isChecked):
		$AnimatedSprite2D.play("win_lilypad")
		lilypad_checked.emit()
		isChecked=true
