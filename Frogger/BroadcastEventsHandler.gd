extends Node

signal frog_death
func on_turtle_dive_with_frog():
	frog_death.emit()

	
