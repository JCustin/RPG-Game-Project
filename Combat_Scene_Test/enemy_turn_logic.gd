extends Node
class_name enemy_turn_logic

var parent_script 

var enemy_queue : Array

var primary_enemy: Node2D
var acting_enemy

var enemies_acted_this_turn : Array
var acting_enemy_index: int

var front_facing_enemy_parts_in_combat: Array
var rear_facing_enemy_parts_in_combat: Array

func _init(parent_script_node: Node2D) -> void:
	parent_script = parent_script_node


func return_active_enemy_parts(forward_combat_direction: bool, enemy):
	if forward_combat_direction == true:
		front_facing_enemy_parts_in_combat = enemy.front_facing_body_parts
		enemy.change_position_by_combat_direction(forward_combat_direction)
		return front_facing_enemy_parts_in_combat
	else:
		rear_facing_enemy_parts_in_combat = enemy.rear_facing_body_parts
		enemy.change_position_by_combat_direction(forward_combat_direction)
		return rear_facing_enemy_parts_in_combat

func execute_enemy_turn(enemy_actor: Node2D, active_players_in_combat: Array):
	var filtered_active_players_in_combat = active_players_in_combat
	filtered_active_players_in_combat.erase(enemy_actor)
	var target = filtered_active_players_in_combat.pick_random()
	
	
	# current test implementation is for the enemy to pick
	# a random player_unit, maybe in the future they can 
	# use more special logic to determine who to attack?
	
	await enemy_actor.choose_attack(target)


func refresh_enemy_queue(primary_enemy: Node2D):
	enemy_queue.clear()
	var facing_forward_flag = primary_enemy.facing_forward
	if facing_forward_flag == true:
		enemy_queue.append_array(front_facing_enemy_parts_in_combat)
	else:
		enemy_queue.append_array(rear_facing_enemy_parts_in_combat)
