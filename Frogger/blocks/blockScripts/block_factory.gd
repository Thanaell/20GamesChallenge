class_name BlockFactory

static var packed_block_scene: PackedScene = preload("res://blocks/configurable_block.tscn") 
static var packed_lilypad_scene: PackedScene = preload("res://blocks/lilypad.tscn") 
static var packed_turtle_scene: PackedScene = preload("res://blocks/turtle.tscn") 


static func create_block(type : Block.BlockType) -> Node :
	match (type):
		Block.BlockType.TURTLE:
			return packed_turtle_scene.instantiate()
		Block.BlockType.LILYPAD:
			return packed_lilypad_scene.instantiate()
		_:
			var block_scene: Node = packed_block_scene.instantiate()
			block_scene.blockType = type
			block_scene.switch_sprite()
			block_scene.set_deadliness()
			return block_scene
