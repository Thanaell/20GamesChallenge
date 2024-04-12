extends NinePatchRect
const game_scene_path = 'res://mainScene.tscn'
func restart():
	get_tree().change_scene_to_file(game_scene_path)
