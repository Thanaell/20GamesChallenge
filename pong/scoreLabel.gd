extends Label


var leftScore :int
var rightScore : int 
var scoreText="0/0"

func update_Score(isLeftScore :bool):
	if (isLeftScore): leftScore+=1
	else: rightScore+=1
	print (leftScore)
	updateDisplay()

func updateDisplay():
	scoreText=str(leftScore)+"/"+str(rightScore)
	text=scoreText
# Called when the node enters the scene tree for the first time.

func _ready():
	text=scoreText

