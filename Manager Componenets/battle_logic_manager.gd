class_name battle_logic_manager extends Node

enum combat_turns {PLAYER_TURN, ENEMY_TURN, FIGHT_NOT_STARTED}
var current_combat_turn : combat_turns = combat_turns.FIGHT_NOT_STARTED

@export var player_turn_logic : player_turn_logic_manager
@export var enemy_turn_logic : enemy_turn_logic_manager
@export var combat_menu :VBoxContainer

signal attack_launched
signal attack_canceled

var player_combatants : Array[base_player_combatant]
var enemy_combatants : Array[base_enemy_combatant]
## called by combat_manager to inform and relay list of enemies and players when combat_manager performs start_battle function
## battle_logic_manager is the source of CONSTANT information for which actors are active in combat
func activate_battle_logic(player_list : Array, enemy_list : Array) -> void:
	player_combatants = player_list
	enemy_combatants = enemy_list
	player_turn_logic.start_player_turn(player_combatants)
	
func deactivate_battle_logic() -> void:
	player_combatants.clear()
	enemy_combatants.clear()
	current_combat_turn = combat_turns.FIGHT_NOT_STARTED

func initiate_attack() -> void:
	pass
	
	
func initiate_skill() -> void:
	pass
		
func open_item_menu() -> void:
	pass

#
#@export var combat_menu : VBoxContainer
#var player_combatants : Array
#var enemy_turn_queue : Array
#
#
#var player_turn_queue : Array
## the player_turn_queue is used when the player's turn begins
## the player ultimately defines the sequence each actor performs
## when an actor performs, they are removed from the player_turn_queue
## the player_turn_queue is then refreshed from the player_combatants array
#
#enum possible_player_target_selections {SELECTING_ENEMY_TARGET, SELECTING_FRIENDLY_TARGET, NOT_SELECTING}
## SELECTING_ENEMY_TARGET - player is currently selecting an enemy target for an attack or skill
## SELECTING_FRIENDLY_TARGET - player is currently selecting a friendly target for an attack or skill
#
#var current_player_target_selection : possible_player_target_selections = possible_player_target_selections.NOT_SELECTING # player always goes first, so they are active. 
#
#enum possible_player_actions {BASIC_ATTACK, SKILL, ITEM, WAITING}
#var current_player_action : possible_player_actions = possible_player_actions.WAITING
#
#enum combat_turns {PLAYER_TURN, ENEMY_TURN, FIGHT_NOT_STARTED}
## PLAYER_TURN - player is currently active ... player_status should be ACTIVE
## ENEMY_TURN - enemy is currently active ... enemy_status should be INACTIVE
#
#var current_combat_turn : combat_turns = combat_turns.FIGHT_NOT_STARTED # player always goes first
#
#var enemy_combatants : Array
#
#var target_enemy : base_enemy_combatant
#var target_player : base_player_combatant
#
#var enemy_combatant_index : int = 0
## the enemy_combatant_index is used to track the enemy currently being selected for attacks or hostile skills
#
#var player_combatant_index : int = 0
## the player_combatant_index is used to track the player currently being selected for friendly skills (e.g., healing)
#var acting_player_index : int = 0
#
#var acting_player : base_player_combatant
#



## used only when a combatant dies
#func remove_dead_combatant(combatant) -> void:
	#if combatant is base_player_combatant:
		#player_combatants.erase(combatant)
	#else:
		#enemy_combatants.erase(combatant)
#
## turn handling
#func start_new_turn() -> void:
	#refresh_player_turn_queue()
	#refresh_enemy_turn_queue()
	#current_combat_turn = combat_turns.PLAYER_TURN
#
#func refresh_player_turn_queue() -> void:
	#player_turn_queue = player_combatants
	#player_combatant_index = 0
	#acting_player_index = 0
	#acting_player = player_turn_queue[player_combatant_index]
#
#func refresh_enemy_turn_queue() -> void:
	#enemy_turn_queue = enemy_combatants
	#enemy_combatant_index = 0
	#
#func remove_actor_from_turn_queue(turn_queue : Array, actor: base_actor_combatant) -> void:
	#player_turn_queue.erase(actor)
	#
#func switch_current_player() -> void:
	#acting_player = player_turn_queue[validate_new_target_index(player_turn_queue, acting_player_index)]
#
# core actions
#func initiate_target_selection() -> void:
	#attack_launched.emit()
	#current_player_target_selection = possible_player_target_selections.SELECTING_ENEMY_TARGET
	#enemy_combatant_index = 0 
	#highlight_target(enemy_combatants[enemy_combatant_index])
#
#func initiate_attack() -> void:
	#current_player_action = possible_player_actions.BASIC_ATTACK
	#initiate_target_selection()
#
#func iniitate_skill() -> void:
	#current_player_action = possible_player_actions.SKILL
	#
#func open_item_menu() -> void:
	#current_player_action = possible_player_actions.ITEM
	#
#func flee() -> void:
	#pass

#
## TARGET SELECTION #
## what are the current limitations of this code?
	## first, it is only focused on targeting enemies.
	## TODO implement code for targeting allies - likely that a majority of the code could be generalized. 
#
#var tween : Tween
#
#func highlight_target(target : base_actor_combatant) -> void:
	#var target_sprite = target.sprite
	#tween = target_sprite.create_tween().set_loops()
	#tween.set_meta("bounder", target_sprite)
	#tween.tween_property(target_sprite, "modulate", Color("ff0000"), 0.50)
	#tween.tween_property(target_sprite, "modulate", Color("ffffff"), 0.50)
#
#func stop_highlighting_current_target() -> void:
	#var target_sprite = tween.get_meta("bounder")
	#tween.stop()
	#tween.tween_property(target_sprite, "modulate", Color("ffffff"), 0.0)
	#tween.custom_step(1.0)
	#tween.kill()
#
#func stop_target_selection() -> void: #target selection could be stoppped due to player canceling OR confirming
	#stop_highlighting_current_target()
	#attack_canceled.emit()
#
#func move_selected_target() -> void:
	#stop_highlighting_current_target()
	#
	#match current_player_target_selection:
		#
		#possible_player_target_selections.SELECTING_ENEMY_TARGET:
			#highlight_target(enemy_turn_queue[validate_new_target_index(enemy_turn_queue, enemy_combatant_index)])
			#
		#possible_player_target_selections.SELECTING_FRIENDLY_TARGET:
			#highlight_target(player_turn_queue[validate_new_target_index(player_turn_queue, player_combatant_index)])
	#
	#
	##move_selected_target does the following:
	## 1. kill the current tween, which is bound to the enemy previously being highlighted
	## 2. check that the new enemy_combatant_index is within bounds of the enemy_combatant list
		## if yes, then pass the enemy_combatant_index with ease
		## if no, then correct the enemy_combtant_index - typically by 'moving to the edge' of the list index (aka reset to 0 or to the max size minus one)
	## 3. highlight the new enemy
	#
	## this workflow is initiated by the player pressing the UI_left or UI_right buttons while player_status is SELECTING_ENEMY_TARGET.
	#
#func validate_new_target_index(combatant_list : Array, index : int) -> int:
	#var combatant_list_size : int = combatant_list.size()
	##print_debug(combatant_list_size)
	##print_debug(enemy_combatant_index)
	#
	#if index < 0:
		#index = (combatant_list_size - 1)
	## if enemy_combatant_index is less than zero, then set the index to one less than the enemy_combatant size.
	## reminder - it is one LESS because the first index is 0, therefore all indexes shift down as so
	#
		#
	#elif index > (combatant_list_size - 1):
		#index = 0
	## if enemy_combatant_index is greater than the size minus one, set the index to zero.
	## reminder - we compare it to the size minus one because, conversely, the size does not start at index 0. Therefore, all indexes shift up. 
	#else:
		#pass
	#
	#return index
	#
#
#func _input(_event: InputEvent) -> void:
	#if current_combat_turn != combat_turns.FIGHT_NOT_STARTED:
		#if Input.is_action_just_pressed("ui_left") and current_player_target_selection == possible_player_target_selections.SELECTING_ENEMY_TARGET:
			#enemy_combatant_index -= 1
			#move_selected_target()
			#
		#if Input.is_action_just_pressed("ui_left") and current_player_target_selection == possible_player_target_selections.SELECTING_FRIENDLY_TARGET:
			#player_combatant_index += 1
		#
		#if Input.is_action_just_pressed("ui_right") and current_player_target_selection == possible_player_target_selections.SELECTING_ENEMY_TARGET:
			#enemy_combatant_index += 1
			#move_selected_target()
			#
		#if Input.is_action_just_pressed("ui_right") and current_player_target_selection == possible_player_target_selections.SELECTING_FRIENDLY_TARGET:
			#player_combatant_index -= 1
			#
		#if Input.is_action_just_pressed("Exit_GUI") and current_player_target_selection == possible_player_target_selections.SELECTING_ENEMY_TARGET:
			#stop_target_selection()
			#
		#if Input.is_action_just_pressed("Movement_Left") and current_player_target_selection == possible_player_target_selections.NOT_SELECTING:
			#acting_player_index -= 1
			#switch_current_player()
			#
		#if Input.is_action_just_pressed("Movement_Right") and current_player_target_selection == possible_player_target_selections.NOT_SELECTING: 
			#acting_player_index += 1
			#switch_current_player()
			#
		#if Input.is_action_just_pressed("ui_accept") and current_player_target_selection == possible_player_target_selections.SELECTING_ENEMY_TARGET and current_player_action == possible_player_actions.BASIC_ATTACK:
			#execute_basic_attack()
	#
## handle attack data
#func execute_basic_attack() -> void:
	#var current_player : base_player_combatant = player_turn_queue[acting_player_index]
	#pass
	#
#
#func attack_target(attack_value : int, target : base_actor_combatant):
	#var target_HP :  int = target.stat_block.basic_HP
	#target_HP -= attack_value
	#print_debug(target_HP)
