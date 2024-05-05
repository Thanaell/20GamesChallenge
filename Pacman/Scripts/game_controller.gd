extends Node

enum GAME_STATE { NORMAL, REVENGE }

var game_state: GAME_STATE = GAME_STATE.NORMAL

@onready var pacman: Pacman = $"../main_scene/pacman"
@onready var blue_ghost: Ghost = $"../main_scene/blue_ghost"
@onready var red_ghost: Ghost = $"../main_scene/red_ghost"
@onready var pink_ghost: Ghost = $"../main_scene/pink_ghost"
@onready var orange_ghost: Ghost = $"../main_scene/orange_ghost"


func on_dot_eaten():
	pass


func on_star_eaten():
	game_state = GAME_STATE.REVENGE
	blue_ghost.change_state(game_state)
	red_ghost.change_state(game_state)
	pink_ghost.change_state(game_state)
	orange_ghost.change_state(game_state)
	$revenge_timer.start()


func on_revenge_end():
	game_state = GAME_STATE.NORMAL
	blue_ghost.change_state(game_state)
	red_ghost.change_state(game_state)
	pink_ghost.change_state(game_state)
	orange_ghost.change_state(game_state)


func on_pacman_hit(ghost_area: Area2D):
	if game_state == GAME_STATE.NORMAL:
		pacman.reset()
		blue_ghost.reset()
		red_ghost.reset()
		pink_ghost.reset()
		orange_ghost.reset()
	else:
		ghost_area.reset()
