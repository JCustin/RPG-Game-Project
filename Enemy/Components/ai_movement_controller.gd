class_name ai_movement_controller extends Node2D

@export var pathfinder : NavigationAgent2D
@export var hearing : ai_hearing_range
@export var sight : ai_sight_component

@export var hearing_radius : int
@export var sight_range : int

var movement_active_flag : bool = false
enum movement_behavior_states {IDLE, PATROL, INVESTIGATE, CHASE, RETREAT}
var movement_behavior : movement_behavior_states = movement_behavior_states.PATROL
var walkable_map : TileMapLayer

func _ready() -> void:
	sight.sight_range = sight_range
	hearing.get_child(0).radius = hearing_radius
	

func return_direction() -> Vector2:
	var direction = global_position.direction_to(pathfinder.target_position)
	return direction
