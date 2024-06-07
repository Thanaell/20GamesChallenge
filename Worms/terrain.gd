extends Node2D

@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var display_polygon: Polygon2D = $Polygon2D


func clip(area_of_effect: Polygon2D):
	var aoe_polygon: PackedVector2Array = PackedVector2Array(area_of_effect.polygon)
	for i in range(len(aoe_polygon)):
		aoe_polygon[i] += area_of_effect.global_position
	
	var polygon_diff = Geometry2D.clip_polygons(display_polygon.polygon, aoe_polygon)
	
	display_polygon.polygon = polygon_diff[0]
	collision_polygon.set_deferred("polygon", polygon_diff[0])
