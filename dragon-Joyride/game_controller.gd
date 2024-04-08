extends Node2D

var score: float

func _process(delta):
	score += delta
	$Label.display_score(int(score))

func on_dragon_hit():
	Highscore.update_highscore(int(score))
