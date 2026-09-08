class_name actor_manager extends Node

signal combat_initiated(combat_players : Array[player_combat_actor_class], combat_enemies: Array[enemy_actor_class])

@export var player_party : Node
@export var enemy_party : Node
@export var map_manager : map_region_manager
@export var area_pull_radius : Area3D
@export var combat_manager : combat_manager_component
var local_enemies : Array[enemy_actor_class]
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
	var player : player_actor_class = player_party.get_child(0)
	player.enemy_contacted.connect(send_combat_signal)
	
# signal is sent to combat_manager
func send_combat_signal(inciting_enemy : enemy_actor_class) -> void:
	var player_combat_actors : Array[combat_player_character]
	var enemy_combat_actors : Array[combat_enemy_character]
	
	for player in player_party.get_children():
		if player is player_actor_class:
			player_combat_actors.append(player.stat_block.combat_counterpart)
			
	# append the inciting enemy - the enemy that contacts the player
	enemy_combat_actors.append(inciting_enemy.stat_block.combat_counterpart)
	# find the enemies local to the player & inciting enemy
	for enemy in local_enemies:
		enemy_combat_actors.append(enemy.stat_block.combat_counterpart)
		
	combat_initiated.emit(player_combat_actors, enemy_combat_actors)
	
