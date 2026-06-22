class_name movement_behavior_resource_base extends Resource

enum movement_behavior_states {PATROL, INVESTIGATE, CHASE, RETREAT}
@export var movement_behavior_status : movement_behavior_states
@export var movement_speed : int 
