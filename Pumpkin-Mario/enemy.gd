class_name Enemy extends RigidBody2D


# Return a boolean to know whether the player dies on collision
func handle_player_collision(force_to_apply: Vector2 = Vector2(0.0, 0.0)) -> bool:
	return true
