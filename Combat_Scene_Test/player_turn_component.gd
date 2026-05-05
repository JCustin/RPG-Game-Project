class_name combat_player_turn_component extends Node

var player_choosing_target_mode : bool = false
var player_turn : bool = false

func start_player_turn(active_actor: Variant) -> void:
	player_turn = true
	
	
func _input(event: InputEvent) -> void:
	if player_turn == true:
		if event.is_action_pressed("Inventory"):
			print_debug("Test")
