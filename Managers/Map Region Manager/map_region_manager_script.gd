class_name map_region_manager extends Node

var item_manager : item_controller
var map : map_region

#signal new_map_loaded(tile_map, pathfinder_grid : AStarGrid2D)

func _ready() -> void:
	load_new_map()

func load_new_map() -> void:
	map = get_child(0)
