class_name actor_manager extends Node

@export var player_party : Node
@export var enemy_party : Node
@export var map_manager : map_region_manager
@export var area_pull_radius : Area3D
var detected_bodies_in_area_pull : Array

func _ready() -> void:
	connect_player_combat_initiation()
	area_pull_radius.body_entered.connect(collect_area_pull_detection)

# TODO - code that pops enemy_party with enemies loaded from map_manager
# TODO - combat initiation between multiple actors

# COMBAT INITIATION
func collect_area_pull_detection(detected_body) -> void:
	detected_bodies_in_area_pull.append(detected_body)
	
# refer to function below when anyone is added to the party. 
func connect_player_combat_initiation() -> void:
	for player in player_party.get_children():
		if player is player_actor_class:
			var player_actor : player_actor_class = player 
			player_actor.enemy_contacted.connect(send_combat_signal)
			
func send_combat_signal(inciting_enemy : enemy_actor_class) -> void:
	detected_bodies_in_area_pull.clear() # to clean the slate for new detected bodies
	var all_players : Array[player_actor_class]
	
	for player in player_party.get_children():
		if player is player_actor_class:
			all_players.append(player)
			
	area_pull_radius.position = inciting_enemy.position
	for body in detected_bodies_in_area_pull:
		print_debug(body)
	
	
