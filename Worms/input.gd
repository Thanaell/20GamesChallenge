extends Node2D

var bullet_scene = preload("res://bullet.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("click"):
		spawn_bullet(get_viewport().get_mouse_position())


func spawn_bullet(mouse_position: Vector2):
	var new_bullet = bullet_scene.instantiate()
	add_child(new_bullet)
	new_bullet.position = mouse_position
