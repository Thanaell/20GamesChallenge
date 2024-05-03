extends Area2D

signal dotEaten

func _ready():
	dotEaten.connect(GameController.on_dot_eaten)
	
func on_dot_eaten(_area : Area2D):
	dotEaten.emit()
	queue_free()
