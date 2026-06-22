class_name actor_controller extends Node
@export var map_manager : map_region_manager 

func _ready() -> void:
	var map : map_region = map_manager.map
	var map_walkable_ground : TileMapLayer = map.walkable_ground
	
	for actor in get_children():
		if actor is enemy_character:
			var enemy_actor : enemy_character = actor
			var enemy_actor_ai_movement_controller = enemy_actor.ai_movement_controller
			#enemy_actor_ai_movement_controller.walkable_map = map_walkable_ground
			
