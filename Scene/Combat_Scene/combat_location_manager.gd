class_name combat_location_manager extends Node

@export var front_player_positions : Node
@export var rear_player_positions : Node
@export var enemy_central_positions : Node

func define_position_map() -> Dictionary: 
	var position_map : Dictionary 
	for child in front_player_positions:
		print_debug(child.name)
	
	return position_map 

func assign_actors_to_positions(
	players : Array[combat_player_character],
	enemies: Array[combat_enemy_character]
):
	var front_positions : Array = front_player_positions.get_children()
	var rear_positions : Array = rear_player_positions.get_children()
	
