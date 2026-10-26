class_name player_turn_logic_manager extends Node

signal player_combatant_died
signal player_turn_ended

enum player_status {BASIC_ATTACK, SKILL, HOSTILE_SKILL, FRIENDLY_SKILL, INVENTORY, WAITING, ACTING, INACTIVE}
var current_player_status : player_status = player_status.INACTIVE

enum player_targeting_choice {TARGETING, NOT_TARGETING}
var current_player_targeting_choice : player_targeting_choice = player_targeting_choice.NOT_TARGETING



var player_turn_queue : Array[base_player_combatant]
var current_active_player : base_player_combatant

var current_target : base_actor_combatant
var tween : Tween

var target_list : Array

# TURN HANDLING
func start_player_turn(player_combatant_list : Array) -> void:
	player_turn_queue = player_combatant_list
	current_player_status = player_status.WAITING
	current_active_player = player_turn_queue[0]
	
func end_player_turn() -> void:
	player_turn_ended.emit()
	current_player_status = player_status.INACTIVE
	
func remove_player_from_turn_queue(actor: base_player_combatant) -> void:
	player_turn_queue.erase(actor)
	if player_turn_queue.size() == 0:
		end_player_turn()
	
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
	
# END TURN HANDLING #

# TARGET HANDLING #
func start_targeting_mode() -> void:
	var logic_manager : battle_logic_manager = get_parent()
	current_player_targeting_choice = player_targeting_choice.TARGETING
	
	if current_player_status == player_status.BASIC_ATTACK or current_player_status == player_status.HOSTILE_SKILL:
		target_list = logic_manager.enemy_combatants
		
	if current_player_status == player_status.FRIENDLY_SKILL:
		target_list = logic_manager.player_combatants

	set_target_from_target_list(0)

func cancel_targeting_mode() -> void:
	stop_highlighting_target()
	current_player_status = player_status.WAITING
	
func attack_target_and_stop_targeting_mode() -> void:
	stop_highlighting_target()
	current_player_status = player_status.ACTING
	
func set_target_from_target_list(index_value : int) -> void:
	if current_target != null:
		stop_highlighting_target()
		
	current_target = target_list[index_value]
	highlight_target()
	
func highlight_target() -> void:
	tween = create_tween()
	tween.set_loops()

	tween.tween_property(current_target.sprite, "modulate", Color("ff0000"), 0.50)
	tween.tween_property(current_target.sprite, "modulate", Color("ffffff"), 0.50)
	
func stop_highlighting_target() -> void:
	tween.stop()
	tween.tween_property(current_target.sprite, "modulate", Color("ffffff"), 0.00)
	tween.custom_step(1.0)
	#tween.kill()
	
func switch_targets(increment_index_value: int) -> void:
	var target_list_size : int = target_list.size()
	var new_index : int
	
	if increment_index_value < 0:
		new_index = (target_list_size - 1)
		
	elif increment_index_value > (target_list_size - 1):
		new_index = 0
		
	else:
		pass
		
	set_target_from_target_list(new_index)

# END TARGET HANDLING #

# MANA HANDLING #

# END MANA HANDLING #

# MENU ACTIONS #
func initiate_basic_attack() -> void:
	current_player_status = player_status.BASIC_ATTACK
	start_targeting_mode()

# input handling
func _input(event: InputEvent) -> void:
	if current_player_status != player_status.INACTIVE:
		
		if current_player_status == player_status.WAITING:
			if event.is_action_pressed("ui_left"):
				switch_current_active_player(-1)
				
			if event.is_action_pressed("ui_right"):
				switch_current_active_player(1)
				
		if current_player_targeting_choice == player_targeting_choice.TARGETING:
			if event.is_action_pressed("Movement_Left") or event.is_action_pressed("ui_left"):
				switch_targets(-1)
				
			if event.is_action_pressed("Movement_Right") or event.is_action_pressed("ui_right"):
				switch_targets(1)
			
			if event.is_action_pressed("Exit_GUI"):
				cancel_targeting_mode()
		
