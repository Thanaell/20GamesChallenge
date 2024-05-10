extends RigidBody2D


func on_kill_goomba_entered(_area : Area2D):
	Character.on_bounce()
	queue_free()
