class_name actor_controller extends Node

@export var map_manager : map_region_manager 

var player_list : Array[player_character]
var enemy_list : Array[enemy_character]
var npc_list : Array[npc_character_class]

func _ready() -> void:
	map_manager.move_player_to_spawn_point.connect(_move_player_to_spawn_point)

func add_actor(actor: CharacterBody2D) -> void:
	if actor is player_character:
		player_list.append(actor)
		
	if actor is enemy_character:
		enemy_list.append(actor)
		
	if actor is npc_character_class:
		npc_list.append(actor)
		
	if get_children().has(actor) == false:
		add_child(actor)
	
func add_actor_array(actor_list : Array[CharacterBody2D]) -> void:
	for actor in actor_list:
		add_actor(actor)

func _move_player_to_spawn_point(spawn_point : Vector2) -> void:
	var player : player_character = player_list[0]
	player.position = spawn_point
