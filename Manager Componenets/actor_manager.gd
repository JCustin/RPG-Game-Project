class_name actor_manager extends Node
@export var player_actors : Node
@export var enemy_actors : Node

# sends this signal out to combat_manager
signal initiate_combat(players : Array[base_player_combatant], enemies : Array[base_enemy_combatant])

func _ready() -> void:
	for players : base_player_actor in player_actors.get_children():
		players.contacted_enemy.connect(prepare_combat_start)
		

func prepare_combat_start(enemy : base_enemy_actor) -> void:
	var all_players : Array[base_player_actor]
	var all_enemies : Array[base_enemy_actor]
	
	
	
