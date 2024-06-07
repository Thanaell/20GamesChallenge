extends RigidBody2D

@onready var area_of_effect: Polygon2D = $area_of_effect


func _process(delta):
	if position.y > get_viewport_rect().size.y:
		queue_free()
	if position.x < 0 || position.x > get_viewport_rect().size.x:
		queue_free()


func on_collide(body: Node):
	if body is StaticBody2D:
		body.clip(area_of_effect)
		call_deferred("queue_free")
