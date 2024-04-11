extends Node

signal frog_death
signal lilypad_checked

func on_turtle_dive_with_frog():
	frog_death.emit()
func on_lilypad_checked():
	lilypad_checked.emit()
	
