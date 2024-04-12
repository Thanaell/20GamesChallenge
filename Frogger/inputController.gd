class_name InputController extends Node2D

enum MoveDirection { UP, DOWN, LEFT, RIGHT }

signal move(direction: MoveDirection)

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		move.emit(MoveDirection.UP)
	if Input.is_action_pressed("ui_down"):
		move.emit(MoveDirection.DOWN)
	if Input.is_action_pressed("ui_left"):
		move.emit(MoveDirection.LEFT)
	if Input.is_action_pressed("ui_right"):
		move.emit(MoveDirection.RIGHT)
