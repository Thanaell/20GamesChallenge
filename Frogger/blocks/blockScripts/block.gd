class_name Block extends Area2D

enum BlockType {LOG, CROCODILE, CAR, TURTLE, SAFE, WATER, ROAD, LILYPAD}

static var blockSize: int = 40

@export var isKill: bool = false
var blockType: BlockType

var log_tex = preload("res://blocks/blocksTextures/log.png") 
var crocodile_tex = preload("res://blocks/blocksTextures/crocodile.png") 
var car_tex = preload("res://blocks/blocksTextures/car.png") 
var safe_tex = preload("res://blocks/blocksTextures/safe.png") 
var water_tex = preload("res://blocks/blocksTextures/water.png") 
var road_tex = preload("res://blocks/blocksTextures/road.png") 

func switch_sprite():
	match blockType:
		BlockType.LOG:
			$Sprite2D.set_texture(log_tex)
		BlockType.CROCODILE:
			$Sprite2D.set_texture(crocodile_tex)
		BlockType.CAR:
			$Sprite2D.set_texture(car_tex)
		BlockType.SAFE:
			$Sprite2D.set_texture(safe_tex)
		BlockType.WATER	:
			$Sprite2D.set_texture(water_tex)
		BlockType.ROAD:
			$Sprite2D.set_texture(road_tex)

func set_deadliness():
	match blockType:
		BlockType.CROCODILE || BlockType.CAR || BlockType.WATER:
			isKill=true
		_:
			isKill=false
