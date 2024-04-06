extends Label

var score = 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score+=delta
	var scoreText = "SCORE : " + str(int(score))
	text=scoreText
