class_name Lane extends Node2D

@export var speed = 0.0
@export var pattern: Array[Block.BlockType] = []

func _ready():
	for block_type: Block.BlockType in pattern:
		var new_block: Node = BlockFactory.create_block(block_type)
		
		# Move other blocks to make room
		for existing_block: Node in get_children():
			existing_block.position.x += Block.blockSize
		
		add_child(new_block)

func _process(delta):
	for existing_block: Node in get_children():
		existing_block.position.x += speed * delta
