extends Node

var highscore: int = 0

func update_highscore(new_score: int):
	if (new_score > highscore):
		highscore = new_score
