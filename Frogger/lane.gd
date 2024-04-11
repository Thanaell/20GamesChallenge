class_name Lane extends Node2D

@export var speed = 0.0
@export var pattern: Array[Block.BlockType] = []

var existing_blocks: Array[Node] = []

func _ready():
	var pattern_repetition: int = 0
	if len(pattern) != 0:
		pattern_repetition = ((get_viewport().size.x / Block.blockSize) / len(pattern)) + 2
	
	for i in range(pattern_repetition):
		for block_type: Block.BlockType in pattern:
			var new_block: Node = BlockFactory.create_block(block_type)
			new_block.position.x -= 1.5 * float(Block.blockSize)
			
			# Rotating the sprite depending on the speed
			if speed < 0:
				new_block.scale.x = -1
			
			# Move other blocks to make room
			for existing_block: Node in existing_blocks:
				existing_block.position.x += Block.blockSize
			
			add_child(new_block)
			existing_blocks.push_front(new_block)

func _process(delta):
	if speed == 0:
		return
	
	for existing_block: Node in existing_blocks:
		existing_block.position.x += speed * delta
	
	if len(existing_blocks) > 0:
		var lane_pixel_size: int = Block.blockSize * len(existing_blocks)
		if speed > 0 && existing_blocks.back().position.x > (lane_pixel_size - 1.5 * float(Block.blockSize)):
			var moving_block: Node = existing_blocks.pop_back()
			moving_block.position.x -= lane_pixel_size
			existing_blocks.push_front(moving_block)
		if speed < 0 && existing_blocks.front().position.x < (-1.5 * float(Block.blockSize)):
			var moving_block: Node = existing_blocks.pop_front()
			moving_block.position.x += lane_pixel_size
			existing_blocks.push_back(moving_block)
