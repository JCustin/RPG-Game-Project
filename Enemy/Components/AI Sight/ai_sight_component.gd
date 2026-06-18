class_name ai_sight_component extends Node2D

var player : player_character
@export var sight_raycast : RayCast2D
@export var sight_range : int 

signal player_spotted(player_last_seen: Vector2)

var spotted_player_flag : bool 

func _ready() -> void:
	_find_player()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	sight_raycast.target_position = direction * sight_range	
	
	if spotted_player_flag == false:
		if sight_raycast.get_collider() is player_character:
			player_spotted.emit(player.global_position)
			spotted_player_flag = true
	
	if spotted_player_flag == true:
		if sight_raycast.get_collider() == null:
			spotted_player_flag = false
			print_debug('Back to false again')

func _find_player() -> void:
	player = get_tree().get_first_node_in_group('Player')
