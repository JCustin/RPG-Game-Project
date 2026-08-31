class_name actor_manager extends Node

@export var player_party : Node
@export var enemy_party : Node
@export var map_manager : map_region_manager
@export var area_pull_radius : Area3D
var local_enemies : Array
var detected_body_counter : int = 0



func _ready() -> void:
	connect_player_combat_initiation()
	area_pull_radius.body_entered.connect(add_local_enemy)
	area_pull_radius.body_exited.connect(remove_local_enemy)
	

# TODO - code that pops enemy_party with enemies loaded from map_manager
# TODO - combat initiation between multiple actors

# COMBAT INITIATION
func add_local_enemy(detected_body) -> void:
	if detected_body is enemy_actor_class:
		local_enemies.append(detected_body)
	
func remove_local_enemy(detected_body) -> void:
	if detected_body in local_enemies:
		local_enemies.erase(detected_body)

# refer to function below when anyone is added to the party. 
func connect_player_combat_initiation() -> void:
	for player in player_party.get_children():
		if player is player_actor_class:
			var player_actor : player_actor_class = player 
			player_actor.enemy_contacted.connect(send_combat_signal)
			
func send_combat_signal(inciting_enemy : enemy_actor_class) -> void:
	var all_players : Array[player_actor_class]
	
	for player in player_party.get_children():
		if player is player_actor_class:
			all_players.append(player)
	
	# take the combat_counterparts for each actor
	var combat_players : Array[player_combat_actor_class] 
	for player : player_actor_class in all_players:
		var combat_counterpart : player_combat_actor_class = player.stat_block.combat_counterpart.instantiate()
		combat_players.append(combat_counterpart)
		
	#var combat_enemies : Array[enemy_combat_actor_class]
	#for enemy : enemy_actor_class in local_enemies:
		#var combat_counterpart : 
