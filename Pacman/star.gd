extends Area2D

signal starEaten

func _ready():
	starEaten.connect(GameController.on_star_eaten)

func on_star_eaten(_area : Area2D):
	starEaten.emit()
	queue_free()

