extends Node

var enemy_queue: Array
var acting_enemy: Node2D
var possible_targets: Array



var enemies_acted_this_turn: Array

var enemy_index: int = 0

signal enemy_turn_ended
func _ready() -> void:
	pass
	

func start_turn():
	enemy_index = 0
	handle_enemy_turn()
	
	
func continue_or_end_enemy_turn():
	if enemies_acted_this_turn.has(acting_enemy):
		if enemy_queue.size() > (enemy_index + 1):
			acting_enemy = enemy_queue[enemy_index + 1]
		else:
			enemy_turn_ended.emit()
		

func handle_enemy_turn():
	var possible_targets = %Player_Turn.player_queue
	await acting_enemy.choose_attack(possible_targets)
	enemies_acted_this_turn += [acting_enemy]
	continue_or_end_enemy_turn()
	
func find_available_body_parts():
	if acting_enemy.front_facing == true:
		print_debug(acting_enemy.front_facing_body_parts)
		return acting_enemy.front_facing_body_parts
	else:
		print_debug("There is no rear part yet")

	
