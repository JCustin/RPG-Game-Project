class_name ai_movement_controller_ARCHIVE extends Node

@export var enemy : enemy_character
@export var collision_box : CollisionShape2D

var movement_active_flag : bool = false

enum movement_behavior_states {IDLE, PATROL, INVESTIGATE, CHASE, RETREAT}
var movement_behavior : movement_behavior_states = movement_behavior_states.PATROL

var active : bool = true
var walkable_map : TileMapLayer
var pathfinder : AStarGrid2D

var target_position : Vector2 = Vector2.ZERO
var moving_towards_target_position_flag : bool = true
var path : Array

var position_record : Array = []

func _ready() -> void:
	moving_towards_target_position_flag = false

func _physics_process(_delta: float) -> void:
	if movement_active_flag == true:
		_handle_movement()
	
func _handle_movement() -> void:
	if moving_towards_target_position_flag == false:
		target_position = _find_target_position()
		path = _find_path_to_target()
		moving_towards_target_position_flag = true
	
	else:
		_move_along_path()
		if path.size() == 0:
			moving_towards_target_position_flag = false
			
			
		if validate_enemy_is_not_stuck() == false:
			moving_towards_target_position_flag = false
	# crazy idea to update the pathfinder to construct a new path around the object
		#if validate_enemy_is_not_stuck() == false:
			#if path.size() > 0:
				#pathfinder.set_point_solid(path[0])
				#path = _find_path_to_target()
		
		

		enemy.velocity = _find_direction() * 50
		
		

			
		enemy.move_and_slide()
	
	
func _find_direction() -> Vector2:
	var direction : Vector2
	
	if path.size() > 0:
		direction = _find_current_position().direction_to(path[0])
	else:
		moving_towards_target_position_flag = false
	
	return direction

func _move_along_path() -> void:
	if _validate_if_enemy_reached_target_position(path[0]) == true:
		if path.size() == 0:
			moving_towards_target_position_flag = false
			pass # need to find way to reset the whole movement workflow
		
		else:
			path.pop_front()


	
	
	#if path.size() > 0:
		#var direction : Vector2 = _find_current_position().direction_to(path[-1])
		#enemy.velocity = direction * 70
		#enemy.move_and_slide()

func _find_path_to_target() -> Array:
	var path_steps : Array = pathfinder.get_id_path(_find_current_position(), target_position, true)
	#print_debug(path_steps)
	return (path_steps)

func _find_target_position() -> Vector2i:
	var position : Vector2i
	match movement_behavior:
		
		movement_behavior_states.PATROL:
			position = walkable_map.get_used_cells().pick_random()

	return position

func _assign_patrol_behavior() -> void:
	movement_behavior = movement_behavior_states.PATROL
	
#func _assign_chase_behavior() -> void:
	#movement_behavior = movement_behavior_states.CHASE
	#
#func _assign_idle_behavior() -> void:
	#movement_behavior = movement_behavior_states.IDLE
	#
#func _assign_retreat_behavior() -> void:
	#movement_behavior = movement_behavior_states.RETREAT
	#
#func _assign_investigate_behavior(investigate_position : Vector2) -> void:
	#movement_behavior = movement_behavior_states.IDLE
	#target_position = investigate_position

func _validate_if_enemy_reached_target_position(targeted_position : Vector2) -> bool:
	var current_position = _find_current_position()
	
	if current_position == targeted_position:
		return true
	else:
		return false
		
func _find_current_position() -> Vector2:
	var position : Vector2 = walkable_map.local_to_map(enemy.position)
	return position

func validate_enemy_is_not_stuck() -> bool:
	if enemy.get_slide_collision_count() > 0:
		return false
	else:
		return true
