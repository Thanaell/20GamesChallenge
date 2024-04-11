extends Node2D

static var max_lane: int = 12

var frog_current_lane: int = 0
var lane_y_coordinates: Array[float] = []
var lane_speeds : Array[float] = []


func _ready():
	for lane in $Level.get_children():
		
		lane_y_coordinates.append(lane.position.y)
		lane_speeds.append(lane.speed)
	lane_y_coordinates.reverse()
	lane_speeds.reverse()


func on_move_input(direction: InputController.MoveDirection):
	if !$Frog.is_moving_vertical && !$Frog.is_moving_horizontal:
		if direction == InputController.MoveDirection.UP && frog_current_lane < max_lane:
			frog_current_lane += 1
			$Frog.vertical_lerp_to_position(lane_y_coordinates[frog_current_lane])
		
		if direction == InputController.MoveDirection.DOWN && frog_current_lane > 0:
			frog_current_lane -= 1
			$Frog.vertical_lerp_to_position(lane_y_coordinates[frog_current_lane])
		
		if direction == InputController.MoveDirection.LEFT:
			var target_x_coordinate = $Frog.position.x - Block.blockSize
			$Frog.horizontal_lerp_to_position(target_x_coordinate)
		
		if direction == InputController.MoveDirection.RIGHT:
			var target_x_coordinate = $Frog.position.x + Block.blockSize
			$Frog.horizontal_lerp_to_position(target_x_coordinate)

func on_frog_collide(area : Area2D):
	if (area.isKill):
		#TODO : handle death
		frog_current_lane = 0
		$Frog.reset($FrogSpawnPosition.position)
		
	else:
		if (area.blockType != Block.BlockType.ROAD):
			$Frog.speed=lane_speeds[frog_current_lane]
		else :
			$Frog.speed = 0