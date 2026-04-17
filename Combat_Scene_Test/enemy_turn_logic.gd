extends Node
class_name enemy_turn_logic

var parent_script 

var enemy_turn : bool = false
var enemy_queue : Array

var primary_enemy: Node2D
var acting_enemy

var enemies_acted_this_turn : Array
var acting_enemy_index: int


var front_facing_enemy_parts_in_combat: Array
var rear_facing_enemy_parts_in_combat: Array

func _init(parent_script_node: Node2D) -> void:
	parent_script = parent_script_node

func set_primary_enemy(primary_enemy_node: Node2D) -> void:
	primary_enemy = primary_enemy_node
	front_facing_enemy_parts_in_combat = primary_enemy.front_facing_body_parts.values()
	rear_facing_enemy_parts_in_combat = primary_enemy.rear_facing_body_parts.values()

func refresh_enemy_queue():
	enemy_queue.clear()
	var facing_forward_flag = primary_enemy.facing_forward
	if facing_forward_flag == true:
		enemy_queue.append_array(front_facing_enemy_parts_in_combat)
	else:
		enemy_queue.append_array(rear_facing_enemy_parts_in_combat)

func kill_enemy(enemy):
	# insert code to kill enemy and trigger end_combat() when 
	# enemy health is dropped to 0 or less
	pass
	
func direct_enemy_to_choose_attack():
	enemy_turn = true
	await acting_enemy.choose_attack()
	enemies_acted_this_turn.append(acting_enemy)

func continue_or_end_turn(): # applicable if enemy has multiple moves
	
	pass
	
func scramble_timeline():
	pass #TODO work on this code when timeline system is built out
	
func start_enemy_turn():
	refresh_enemy_queue()
	acting_enemy = enemy_queue[0]
	direct_enemy_to_choose_attack()

func continue_or_end_enemy_turn():
	if enemies_acted_this_turn.has(acting_enemy) == false:
		pass
	
	if enemy_queue.size() > (acting_enemy_index + 1):
		if enemy_queue[acting_enemy_index + 1].has_method("choose_attack") == true:
			acting_enemy = enemy_queue[acting_enemy_index + 1]
			acting_enemy_index += 1
			direct_enemy_to_choose_attack()
	
	elif enemy_queue.size() <= (acting_enemy_index + 1):
		pass
