extends Area2D

var baseMoveSpeedUp = 500.0
var baseMoveSpeedDown = 300.0

const upSprite = preload("res://Assets/dragon-joyride1.png")
const downSprite = preload("res://Assets/dragon-joyride2.png")

const menu_scene_path = 'res://menu.tscn'

signal dragon_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _handle_collision(area:Area2D):
	dragon_hit.emit()
	get_tree().change_scene_to_file.bind(menu_scene_path).call_deferred()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		position-=Vector2(0,baseMoveSpeedUp*delta)
		$Sprite2D.set_texture(upSprite)
		
	else :
		position+=Vector2(0,baseMoveSpeedDown*delta)
		$Sprite2D.set_texture(downSprite)
	position.y = clamp(position.y,0,get_viewport_rect().size.y)


