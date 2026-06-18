class_name ai_movement_controller extends Node

@export var enemy : enemy_character
@export var collision_box : CollisionShape2D

var movement_active_flag : bool = false

enum movement_behavior_states {IDLE, PATROL, INVESTIGATE, CHASE, RETREAT}
var movement_behavior : movement_behavior_states = movement_behavior_states.PATROL

var walkable_map : TileMapLayer

signal found_target_position(position: Vector2)

func _ready() -> void:
	var map : map_region = get_tree().get_first_node_in_group('Map')
	walkable_map = map.walkable_ground
	_find_target_position()

func _find_target_position() -> Vector2:
	var position : Vector2
	match movement_behavior:
		
		movement_behavior_states.IDLE:
			position = enemy.global_position
		
		movement_behavior_states.PATROL:
			position = walkable_map.get_used_cells().pick_random()

			
			#position = walkable_map.get_used_cells().pick_random()
			#print_debug('Patrol position',  position, ' current position: ', enemy.global_position)
			
		movement_behavior_states.INVESTIGATE:
			pass
			
		movement_behavior_states.CHASE:
			pass
			
		movement_behavior_states.RETREAT:
			pass
	
	return position
