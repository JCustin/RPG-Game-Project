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

func return_active_enemy_parts(combat_direction: bool, enemy):
	if combat_direction == true:
		front_facing_enemy_parts_in_combat = enemy.front_facing_body_parts.values()
		return front_facing_enemy_parts_in_combat
	else:
		#rear_facing_enemy_parts_in_combat = primary_enemy.rear_facing_body_parts.values()
		return rear_facing_enemy_parts_in_combat

func start_enemy_turn(primary_enemy: Node2D, active_players_in_combat: Array):
	acting_enemy = primary_enemy
	var target_player = active_players_in_combat.pick_random()
	direct_enemy_to_choose_attack(target_player)

func refresh_enemy_queue(primary_enemy: Node2D):
	enemy_queue.clear()
	var facing_forward_flag = primary_enemy.facing_forward
	if facing_forward_flag == true:
		enemy_queue.append_array(front_facing_enemy_parts_in_combat)
	else:
		enemy_queue.append_array(rear_facing_enemy_parts_in_combat)
#
#func kill_enemy(enemy):
	## insert code to kill enemy and trigger end_combat() when 
	## enemy health is dropped to 0 or less
	#pass
	#
func direct_enemy_to_choose_attack(target_player: Node2D):
	acting_enemy.choose_attack(target_player)
