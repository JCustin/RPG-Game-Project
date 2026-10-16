class_name battle_logic_manager extends Node

signal attack_launched
signal attack_canceled

@export var combat_menu : VBoxContainer
var player_combatants : Array


var player_turn_queue : Array
# the player_turn_queue is used when the player's turn begins
# the player ultimately defines the sequence each actor performs
# when an actor performs, they are removed from the player_turn_queue
# the player_turn_queue is then refreshed from the player_combatants array

enum player_statuses {SELECTING_TARGET, ACTIVE, STUNNED, INACTIVE}
# SELECTING_TARGET - player is currently selecting a target for an attack or skill
# ACTIVE - player is active and game is waiting for an action (attack, skill, item, flee)
# STUNNED - player's team has been stunned (i.e., team has started to panic)
# INACTIVE - player is currently inactive due to enemy acting

var current_player_status : player_statuses = player_statuses.ACTIVE # player always goes first, so they are active. 

enum combat_turns {PLAYER_TURN, ENEMY_TURN}
# PLAYER_TURN - player is currently active ... player_status should be ACTIVE
# ENEMY_TURN - enemy is currently active ... enemy_status should be INACTIVE

var current_combat_turn : combat_turns = combat_turns.PLAYER_TURN # player always goes first

var enemy_combatants : Array



# called by combat_manager to inform and relay list of enemies and players when combat_manager performs start_battle function
# battle_logic_manager is the source of CONSTANT information for which actors are active in combat
func parse_combatants(player_list : Array, enemy_list : Array):
	player_combatants = player_list
	enemy_combatants = enemy_list


# used only when a combatant dies
func remove_dead_combatant(combatant):
	if combatant is base_player_combatant:
		player_combatants.erase(combatant)
	else:
		enemy_combatants.erase(combatant)


# core actions
func initiate_target_selection():
	disable_menu()
	current_player_status = player_statuses.SELECTING_TARGET
	enemy_combatant_index = 0 
	highlight_enemy(enemy_combatants[enemy_combatant_index])
	
	pass

func initiate_attack():
	pass

func iniitate_skill():
	pass
	
func open_item_menu():
	pass
	
func flee():
	pass


# TARGET SELECTION #
# what are the current limitations of this code?
	# first, it is only focused on targeting enemies.
	# TODO implement code for targeting allies - likely that a majority of the code could be generalized. 


var enemy_combatant_index : int = 0
# the enemy_combatant_index is used to track the enemy currently being selected for attacks or hostile skills

var player_combatant_index : int = 0
# the player_combatant_index is used to track the player currently being selected for friendly skills (e.g., healing)

var tween : Tween

func find_sprite(parent_node) -> Sprite3D:
	var sprite_node : Sprite3D
	for child_node in parent_node.get_children():
		if child_node is Sprite3D:
			sprite_node = child_node
		else:
			pass
	return sprite_node

func highlight_enemy(enemy : base_enemy_combatant):
	var enemy_sprite = find_sprite(enemy)
	tween = enemy_sprite.create_tween().set_loops()
	tween.set_meta("bounder", enemy_sprite)
	tween.tween_property(enemy_sprite, "modulate", Color("ff0000"), 0.50)
	tween.tween_property(enemy_sprite, "modulate", Color("ffffff"), 0.50)

func stop_highlighting_current_enemy():
	var enemy_sprite = tween.get_meta("bounder")
	tween.stop()
	tween.tween_property(enemy_sprite, "modulate", Color("ffffff"), 0.0)
	tween.custom_step(1.0)
	tween.kill()

func stop_target_selection(): #target selection could be stoppped due to player canceling OR confirming
	stop_highlighting_current_enemy()
	restore_menu()

func move_selected_target():
	stop_highlighting_current_enemy()
	validate_new_target_index()
	highlight_enemy(enemy_combatants[enemy_combatant_index])
	
	#move_selected_target does the following:
	# 1. kill the current tween, which is bound to the enemy previously being highlighted
	# 2. check that the new enemy_combatant_index is within bounds of the enemy_combatant list
		# if yes, then pass the enemy_combatant_index with ease
		# if no, then correct the enemy_combtant_index - typically by 'moving to the edge' of the list index (aka reset to 0 or to the max size minus one)
	# 3. highlight the new enemy
	
	# this workflow is initiated by the player pressing the UI_left or UI_right buttons while player_status is SELECTING_TARGET.
	

func validate_new_target_index() -> void:
	var enemy_combatant_size : int = enemy_combatants.size()
	#print_debug(enemy_combatant_size)
	#print_debug(enemy_combatant_index)
	
	if enemy_combatant_index < 0:
		enemy_combatant_index = (enemy_combatant_size - 1)
	# if enemy_combatant_index is less than zero, then set the index to one less than the enemy_combatant size.
	# reminder - it is one LESS because the first index is 0, therefore all indexes shift down as so
	
		
	elif enemy_combatant_index > (enemy_combatant_size - 1):
		enemy_combatant_index = 0
	# if enemy_combatant_index is greater than the size minus one, set the index to zero.
	# reminder - we compare it to the size minus one because, conversely, the size does not start at index 0. Therefore, all indexes shift up. 
		
	else:
		pass
	



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_left") and current_player_status == player_statuses.SELECTING_TARGET:
		enemy_combatant_index -= 1
		move_selected_target()
	
	if Input.is_action_just_pressed("ui_right") and current_player_status == player_statuses.SELECTING_TARGET:
		enemy_combatant_index += 1
		move_selected_target()
		
		
	if Input.is_action_just_pressed("Exit_GUI") and current_player_status == player_statuses.SELECTING_TARGET:
		stop_target_selection()
	

		

# menu handling
func restore_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = false
		
func disable_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = true
