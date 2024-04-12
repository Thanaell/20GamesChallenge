extends Node2D

static var max_lane: int = 12

var max_health = 3
var current_health = 3

var checked_lilypads = 0
var max_lilypads = 5

var frog_current_lane: int = 0
var lane_y_coordinates: Array[float] = []
var lane_speeds : Array[float] = []

var should_reset_position_next_frame = false
var should_take_damage_next_frame = false

const game_over_scene_path = 'res://game_over_menu.tscn'
const victory_menu_scene_path = 'res://victory_menu.tscn'


func _ready():
	#Connecting events from individual blocks through broadcastHandler
	BroadcastEventsHandler.frog_death.connect(on_frog_death)
	BroadcastEventsHandler.lilypad_checked.connect(on_lilypad_checked)
	for lane in $Level.get_children():
		lane_y_coordinates.append(lane.position.y)
		lane_speeds.append(lane.speed)
	lane_y_coordinates.reverse()
	lane_speeds.reverse()
	
	$Health_UI.play("full")


func _process(_delta):
	if should_take_damage_next_frame:
		should_take_damage_next_frame = false
		on_frog_death()
	if should_reset_position_next_frame:
		should_reset_position_next_frame = false
		reset_frog()


func on_lilypad_checked():
	checked_lilypads += 1
	if (checked_lilypads == max_lilypads):
		get_tree().change_scene_to_file(victory_menu_scene_path)


func damage_frog():
	current_health -= 1
	match current_health :
		3 : 
			$Health_UI.play("full")
		2 : 
			$Health_UI.play("two_remaining")
		1 : 
			$Health_UI.play("one_remaining")
		0 : 
			$Health_UI.play("empty")
			get_tree().change_scene_to_file(game_over_scene_path)


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


func reset_frog():
	$Frog.reset($FrogSpawnPosition.position)
	frog_current_lane = 0


func on_frog_death():
	damage_frog()
	reset_frog()


func on_frog_collide(area : Area2D):
	if (area.blockType == Block.BlockType.TURTLE):
		area.hasFrog = true
	if (area.blockType == Block.BlockType.LILYPAD):
		should_reset_position_next_frame = true
	if (area.isKill):
		should_take_damage_next_frame = true
	else:
		if (area.blockType != Block.BlockType.ROAD):
			$Frog.speed = lane_speeds[frog_current_lane]
		else:
			$Frog.speed = 0
