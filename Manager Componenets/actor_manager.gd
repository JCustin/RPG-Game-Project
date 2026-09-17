class_name actor_manager extends Node
@export var player_actors : Node
@export var enemy_actors : Node

# sends this signal out to combat_manager
signal initiate_combat(players : Array[base_player_actor], enemies : Array[base_enemy_actor])

func _ready() -> void:
	for players : base_player_actor in player_actors.get_children():
		players.contacted_enemy.connect(prepare_combat_start)
		

func prepare_combat_start(surrounding_enemies : Array[base_enemy_actor]) -> void:
	var player_party : Array[base_player_actor]
	for child in player_actors.get_children():
		if child is base_player_actor:
			player_party.append(child)
	
	print_debug(player_party)
	initiate_combat.emit(player_party, surrounding_enemies)
