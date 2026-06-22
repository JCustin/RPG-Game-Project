class_name patrol_movement_behavior extends movement_behavior_resource_base

var patrol_point

func _find_patrol_point() -> void:
	var tree : SceneTree = Engine.get_main_loop()
	var tile_map = tree.get_first_node_in_group('Map')
	var walkable_tile_map_layer : TileMapLayer = tile_map.get_child(1)
	var possible_tiles = walkable_tile_map_layer.get_used_cells()
	movement_target.emit(possible_tiles.pick_random())

func get_velocity() -> Vector2:
	var velocity : Vector2 = patrol_point * movement_speed
	return velocity 
