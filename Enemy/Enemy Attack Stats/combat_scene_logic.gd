class_name combat_scene_class extends Node2D
var combat_turn_handler : combat_turn_handler_component = combat_turn_handler_component.new()
var timeline : combat_timeline_system = combat_timeline_system.new()

#var basic_combat_logic : basic_attack_combat_component

var active_actor : Variant
var player_actors : Array
var enemy_actors : Array

var player_turn : bool = false
var turn_queue : Array

var player_choosing_target : bool 

enum state {player_turn, interim, enemy_turn}

#signal combat_won
#signal combat_fled
#signal combat_lost

func cust_init(player_initiating_combat: player_character, enemy_initiating_combat: enemy_character):
	var all_actors : Array
	
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


func _prepare_actors(player: combat_player_character, enemy: combat_enemy_character) -> void:
	player.position = Vector2(950,500)
	enemy.position = Vector2(500, 300)
	enemy.scale = Vector2(2.0, 2.0)
	
func _facilitate_turn():
	await get_tree().create_timer(0.5).timeout
	
	if active_actor is combat_enemy_character:
		
	
	if active_actor is combat_enemy_character:
		toggle_player_GUI()
		_execute_enemy_turn()
	else:
		toggle_player_GUI()

func _execute_enemy_turn():
	var enemy : combat_enemy_character = active_actor
	enemy.execute_turn(player_actors)
	
func handle_attack(target, attack_damage: int, attack_type: String, attack_description: String):
	target.stat_block.HP - attack_damage
	%Combat_Description_Text.prompt_combat_description(attack_description)
	continue_or_end_turn()
	
func continue_or_end_turn():
	var current_turn_queue_index: int = turn_queue.find(active_actor)
	var next_turn_queue_index: int = current_turn_queue_index + 1
	
	if turn_queue.size() >= next_turn_queue_index:
		active_actor = turn_queue[next_turn_queue_index]
	else:
		active_actor = turn_queue[0]
		
	_facilitate_turn()
	

func open_special_attack_pool():
	pass
	
func attempt_to_flank():
	pass
	
func open_inventory():
	pass
	
# following section of code is dedicated to when player is initiating a basic attack
func initiate_basic_attack():
	%Attack.disabled = true
	var basic_attack_component = basic_attack_combat_component.new()
	add_child(basic_attack_component)
	var enemy : combat_enemy_character = enemy_actors[0]
	basic_attack_component.init_possible_targets(enemy.limbs)
	
	basic_attack_component.basic_attack_aborted.connect(
		func(): %Attack.disabled = false
		)
		
	basic_attack_component.basic_attack_performed.connect(
		func(target): 
		%Attack.set_focus_mode(Control.FOCUS_NONE)
		%Attack.disabled = false
		var player_actor : combat_player_character = active_actor
		pass
		)
	
	
	
func initiate_conversation():
	pass
	
func attempt_to_flee():
	pass

func toggle_player_GUI():
	for child in %Combat_Player_Actions_Container.get_children():
		child.disabled = !child.disabled
