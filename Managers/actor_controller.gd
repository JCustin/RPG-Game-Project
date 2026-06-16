class_name actor_controller extends Node
@export var map_manager : map_region_manager 

func _ready() -> void:
	_connect_signals()
	
func _connect_signals() -> void:
	map_manager.new_map_loaded.connect(_pass_pathfinder_to_actors)

func _pass_pathfinder_to_actors(map : map_region, pathfinder_grid : AStarGrid2D) -> void:
	for actor in get_children():
		if actor is enemy_character:
			var enemy_actor : enemy_character = actor
			var enemy_ai_controller : ai_movement_controller = enemy_actor.AI_movement_controller
			enemy_ai_controller.pathfinder = pathfinder_grid
			enemy_ai_controller.walkable_map = map.walkable_ground
		else:
			pass
