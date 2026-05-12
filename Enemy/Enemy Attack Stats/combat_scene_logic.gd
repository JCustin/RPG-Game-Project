class_name combat_scene_class extends Node2D
var combat_turn_handler : combat_turn_handler_component = combat_turn_handler_component.new()
var timeline : combat_timeline_system = combat_timeline_system.new()
#var basic_combat_logic : basic_attack_combat_component

var active_actor : Variant
var player_actors : Array
var enemy_actors : Array

var player_turn : bool = false
var turn_queue : Array

var possible_combat_direction = global_enums.combat_direction
var current_combat_direction : int

enum combat_states {player_turn, interim, enemy_turn}
var current_combat_state : int

#signal combat_won
#signal combat_fled
#signal combat_lost


func cust_init(player_initiating_combat: player_character, enemy_initiating_combat: enemy_character):
	var all_actors : Array
	print_debug(player_initiating_combat, enemy_initiating_combat)
	
	var player = player_initiating_combat.combat_counterpart
	var enemy = enemy_initiating_combat.combat_counterpart
	player_actors.append(player)
	enemy_actors.append(enemy)
	
	all_actors.append(player)
	all_actors.append(enemy)
	
	for actor in all_actors:
		add_child(actor)
	
	_connect_signals()
	turn_queue = timeline.assign_turn_queue(all_actors)
	active_actor = turn_queue[0]
	
	_match_combat_state_based_on_active_actor()
	_prepare_actors(player, enemy)
	%Combat_Description_Text.prompt_combat_description(str("You stumble upon ", enemy_actors[0].unit_name, "!"))
	

func _connect_signals() -> void:
	var enemy : combat_enemy_character = enemy_actors[0]
	enemy.executed_attack.connect(handle_attack)
	%Combat_Description_Text.combat_description_closed.connect(_facilitate_turn)
	%Attack.pressed.connect(initiate_basic_attack)
	
	%Special.pressed.connect(open_special_attack_pool)
	%Flank.pressed.connect(attempt_to_flank)
	%Item.pressed.connect(open_inventory)
	%Talk.pressed.connect(initiate_conversation)
	%Flee.pressed.connect(attempt_to_flee)
	
	for player : combat_player_character in player_actors:
		player.executed_attack.connect(handle_attack)
		

func _prepare_actors(player: combat_player_character, enemy: combat_enemy_character) -> void:
	player.position = Vector2(950,500)
	enemy.position = Vector2(500, 300)
	enemy.scale = Vector2(2.0, 2.0)
	_toggle_player_GUI(false)
	
func continue_or_end_turn():
	var current_turn_queue_index: int = turn_queue.find(active_actor)
	var next_turn_queue_index: int = (current_turn_queue_index + 1)
	if turn_queue.size() > next_turn_queue_index:
		active_actor = turn_queue[next_turn_queue_index]
	else:
		active_actor = turn_queue[0]

	_facilitate_turn()

func _facilitate_turn():
	await get_tree().create_timer(1.0).timeout
	_match_combat_state_based_on_active_actor()
	match	 current_combat_state:
		
		combat_states.player_turn:
			_toggle_player_GUI(true)
			
		combat_states.enemy_turn:
			_toggle_player_GUI(false)
			_execute_enemy_turn()

func _execute_enemy_turn():
	var enemy : combat_enemy_character = active_actor
	enemy.execute_turn(player_actors)
	
func handle_attack(target, attack_damage: int, attack_type: String, attack_description: String):
	
	if active_actor is combat_player_character:
		var enemy_target : enemy_limb_class = target
		enemy_target.receive_limb_damage(attack_damage)
		
	else:
		var player_target : combat_player_character = target
		player_target.stat_block.HP -= attack_damage
		
		#if player_target.stat_block.HP <= 0:
			
	
	%Combat_Description_Text.prompt_combat_description(attack_description)
	continue_or_end_turn()
	
func _match_combat_state_based_on_active_actor():
	if active_actor is combat_player_character:
		current_combat_state = combat_states.player_turn
	else:
		current_combat_state = combat_states.enemy_turn


func open_special_attack_pool():
	pass
	
func attempt_to_flank():
	# for now, this will be a 100% chance.
	var enemy : combat_enemy_character = enemy_actors[0]
	match current_combat_direction:
		
		possible_combat_direction.forward:
			current_combat_direction = possible_combat_direction.rear
			
		
		possible_combat_direction.rear:
			current_combat_direction = possible_combat_direction.forward
			
	enemy.switch_direction(current_combat_direction)
	
	
	pass
	
func open_inventory():
	pass
	
# following section of code is dedicated to when player is initiating a basic attack
func initiate_basic_attack():
	%Attack.disabled = true
	
	var basic_attack_component = basic_attack_combat_component.new()
	add_child(basic_attack_component)
	var enemy : combat_enemy_character = enemy_actors[0]
	var enemy_limbs = enemy.get_limbs_based_on_combat_direction(current_combat_direction)
	
	
	basic_attack_component.init_possible_targets(enemy_limbs)
	
	basic_attack_component.basic_attack_aborted.connect(
		func(): %Attack.disabled = false
		)
		
	basic_attack_component.basic_attack_performed.connect(
		func(target): 
		%Attack.set_focus_mode(Control.FOCUS_NONE)
		%Attack.disabled = false
		var player_actor : combat_player_character = active_actor
		player_actor.deal_basic_attack(target)
		)
	
	
	
func initiate_conversation():
	var dialogue : DialogicAnimation
	var enemy : combat_enemy_character = enemy_actors[0]
	var enemy_dialogue : DialogicTimeline = enemy.combat_dialogue_options
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.start(enemy_dialogue)
	
	
func attempt_to_flee():
	pass

func _toggle_player_GUI(toggle : bool) -> void:
	if toggle == true:
		for child in %Combat_Player_Actions_Container.get_children():
			child.disabled = false
	else:
		for child in %Combat_Player_Actions_Container.get_children():
			child.disabled = true
