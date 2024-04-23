extends Node2D

var score = 0
var menu_path = "res://main_menu.tscn"

func ship_crashed():
	get_tree().change_scene_to_file.bind(menu_path).call_deferred()
