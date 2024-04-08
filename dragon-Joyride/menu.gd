extends NinePatchRect

const game_scene_path = 'res://main.tscn'

func _ready():
	$Label.text = 'HIGHSCORE : ' + str(Highscore.highscore)

func on_button_pressed():
	get_tree().change_scene_to_file(game_scene_path)
