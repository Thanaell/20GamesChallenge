extends Node2D

signal move_up
signal move_down

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		move_up.emit()
	if Input.is_action_pressed("ui_down"):
		move_down.emit()
