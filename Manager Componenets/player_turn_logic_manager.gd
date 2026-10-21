class_name player_turn_logic_manager extends Node

signal player_combatant_died


enum player_status {BASIC_ATTACK, SKILL, INVENTORY, WAITING, INACTIVE}
var current_player_status : player_status = player_status.INACTIVE

enum player_targeting_choice {ENEMIES, PLAYERS, NONE}
var current_player_targeting_choice : player_targeting_choice = player_targeting_choice.NONE

var combat_mana: combat_mana_stat_block = combat_mana_stat_block.new()

var player_turn_queue : Array[base_player_combatant]
var current_active_player : base_player_combatant

var current_target : base_actor_combatant
var tween : Tween

func start_player_turn(player_combatant_list : Array) -> void:
	player_turn_queue = player_combatant_list
	current_player_status = player_status.WAITING
	current_active_player = player_turn_queue[0]
	
func remove_player_from_turn_queue(actor: base_player_combatant) -> void:
	player_turn_queue.erase(actor)
	
func switch_current_active_player(switch_value: int) -> void:
	# validate that the new value is valid
	var index = (player_turn_queue.find(current_active_player) + switch_value)
	var player_turn_queue_size : int = player_turn_queue.size()

	if index < 0:
		index = (player_turn_queue_size - 1)
	# if enemy_combatant_index is less than zero, then set the index to one less than the enemy_combatant size.
	# reminder - it is one LESS because the first index is 0, therefore all indexes shift down as so
	
		
	elif index > (player_turn_queue_size - 1):
		index = 0
	# if enemy_combatant_index is greater than the size minus one, set the index to zero.
	# reminder - we compare it to the size minus one because, conversely, the size does not start at index 0. Therefore, all indexes shift up. 
	else:
		pass
	
	# check if there is more than one player
	var projected_active_player : base_player_combatant = player_turn_queue[index]
	
	if projected_active_player == current_active_player:
		pass
	
	else:
		# draw the old current_player out
		var center_player_position : Vector3 = current_active_player.position
		var swap_away_point : Vector3 = get_parent().get_parent().player_left_position.position
		
		tween = create_tween()
		tween.tween_property(current_active_player, "position", swap_away_point, 2.0).finished
		current_active_player = player_turn_queue[index]
		print_debug(current_active_player)
		await tween.tween_property(current_active_player, "position", center_player_position, 2.0).finished
		#tween.kill()
	
	
	#tween = current_active_player.create_tween()
	#tween.stop()
	#tween.tween_property(current_active_player, "sprite", 
	#tween.custom_step(0.5)
	#tween.kill()
	#
	#current_active_player = player_turn_queue[index]
	#tween = current_active_player.create_tween()
	#tween.stop()
	#tween.tween_property(current_active_player, "global_position", center_player_position, 0.25)
	#tween.custom_step(1.0)
	
	

# input handling
func _input(event: InputEvent) -> void:
	if current_player_status != player_status.INACTIVE:
		if event.is_action_pressed("ui_left") and current_player_status == player_status.WAITING:
			switch_current_active_player(-1)
			
		if event.is_action_pressed("ui_right") and current_player_status == player_status.WAITING:
			switch_current_active_player(1)
