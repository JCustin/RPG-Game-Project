class_name ai_movement_controller extends Node

@export var enemy : enemy_character

var movement_active_flag : bool = false

enum movement_behavior_states {IDLE, PATROL, INVESTIGATE, CHASE, RETREAT}
var movement_behavior : movement_behavior_states = movement_behavior_states.PATROL

var active : bool = true
var map_space : TileMapLayer
var pathfinder : AStarGrid2D

var target_position : Vector2 = Vector2(0,0)
var moving_towards_target_position_flag : bool = false
var path : Array

func _ready() -> void:
	var map : map_region = get_tree().get_first_node_in_group('Map')
	map_space = map.walkable_ground
	pathfinder = map.pathfinder

func _physics_process(delta: float) -> void:
	if movement_active_flag == true:
		_handle_movement()

func _handle_movement() -> void:
	# find the latest pathfinder points
	var enemy_position : Vector2 = map_space.local_to_map(enemy.position.round())

	# this flag is too binary, may not be compatible with a chase behavior
	if moving_towards_target_position_flag == false:
		target_position =  _find_target_position()
		path = pathfinder.get_point_path(enemy_position, target_position, true)
		moving_towards_target_position_flag = true
	
	else:
		if _validate_if_enemy_reached_target_position() == true:
			if path.size() == 1:
				moving_towards_target_position_flag = false
			else:
				path.pop_front()
				print_debug('This is path: ', path)

		var direction : Vector2 = enemy_position.direction_to(target_position)
		enemy.velocity = direction * 40
		enemy.move_and_slide()

func _find_target_position() -> Vector2:
	var position : Vector2
	match movement_behavior:
		
		movement_behavior_states.IDLE:
			pass
		
		movement_behavior_states.PATROL:
			position = map_space.get_used_cells().pick_random()
			
		movement_behavior_states.INVESTIGATE:
			pass
			
		movement_behavior_states.CHASE:
			var player = get_tree().get_first_node_in_group('Player')
			position = player.position
			
		movement_behavior_states.RETREAT:
			position = map_space.get_used_cells().pick_random()
			
	return position

func _assign_patrol_behavior() -> void:
	movement_behavior = movement_behavior_states.PATROL
	
func _assign_chase_behavior() -> void:
	movement_behavior = movement_behavior_states.CHASE
	
func _assign_idle_behavior() -> void:
	movement_behavior = movement_behavior_states.IDLE
	
func _assign_retreat_behavior() -> void:
	movement_behavior = movement_behavior_states.RETREAT
	
func _assign_investigate_behavior() -> void:
	movement_behavior = movement_behavior_states.IDLE

func _validate_if_enemy_reached_target_position() -> bool:
	var enemy_position : Vector2 = map_space.local_to_map(enemy.position.round())
	
	if enemy_position == target_position:
		return true
	else:
		#print_debug(enemy.position, ' ', target_position)
		return false
