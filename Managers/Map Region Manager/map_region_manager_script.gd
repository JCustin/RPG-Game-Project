class_name map_region_manager extends Node

signal move_player_to_spawn_point(spawn_point: Vector2)

var item_manager : item_controller
var map : map_region
var current_map_region_position : Vector2
var map_database : master_map_region_list = master_map_region_list.new()

func _ready() -> void:
	current_map_region_position = Vector2.ZERO
	_load_map(map_database.map_database[Vector2(0,0)])

func _free_map() -> void:
	if get_children().size() != 0:
		map.queue_free()

func _load_map(map_uid : String):
	map = load(map_uid).instantiate()
	await add_child(map)
	map.player_transitioning_regions.connect(_transition_to_new_map)

func _transition_to_new_map(direction: Vector2) -> void:
	current_map_region_position += direction
	_free_map()
	await get_tree().physics_frame
	var new_map_region_uid : String = map_database.map_database[current_map_region_position]
	_load_map(new_map_region_uid)
	move_player_to_spawn_point.emit(_find_spawn_point(direction))
	
func _find_spawn_point(direction: Vector2) -> Vector2:
	var spawn_point : Node2D
	match direction:
		Vector2(0,1):
			spawn_point = map.south_transition.spawn_point
		Vector2(0, -1):
			spawn_point = map.north_transition.spawn_point
		Vector2(1,0):
			spawn_point = map.west_transition.spawn_point
		Vector2(-1,0):
			spawn_point = map.east_transition.spawn_point
			
	return spawn_point.global_position
	
