extends Node2D

static var max_lane: int = 12

var frog_current_lane: int = 0

var lane_y_coordinates: Array[float] = []

func _ready():
	for lane in $Level.get_children():
		lane_y_coordinates.append(lane.position.y)
	lane_y_coordinates.reverse()
	print (lane_y_coordinates)

func on_move_up_input():
	if frog_current_lane >= max_lane || $Frog.is_moving_vertical || $Frog.is_moving_horizontal:
		return

	frog_current_lane += 1
	$Frog.vertical_lerp_to_position(lane_y_coordinates[frog_current_lane])

func on_move_down_input():
	if frog_current_lane <= 0 || $Frog.is_moving_vertical || $Frog.is_moving_horizontal:
		return
	
	if !$Frog.is_moving_vertical && !$Frog.is_moving_horizontal:
		frog_current_lane -= 1
		$Frog.vertical_lerp_to_position(lane_y_coordinates[frog_current_lane])
