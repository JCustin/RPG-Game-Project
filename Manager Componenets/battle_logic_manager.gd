class_name battle_logic_manager extends Node

enum combat_turns {PLAYER_TURN, ENEMY_TURN, INACTIVE}
var current_combat_turn : combat_turns = combat_turns.INACTIVE

@export var player_turn_logic : player_turn_logic_manager
@export var enemy_turn_logic : enemy_turn_logic_manager
@export var combat_menu :VBoxContainer
@export var skill_item_list : skill_item_list_logic

var combat_mana: combat_mana_stat_block = combat_mana_stat_block.new()

var player_combatants : Array[base_player_combatant]
var enemy_combatants : Array[base_enemy_combatant]

func _ready() -> void:
	player_turn_logic.player_combatant_died.connect(func(): pass)
	player_turn_logic.player_turn_ended.connect(start_new_enemy_turn)
	

## called by combat_manager to inform and relay list of enemies and players when combat_manager performs start_battle function
## battle_logic_manager is the source of CONSTANT information for which actors are active in combat
func activate_battle_logic(player_list : Array, enemy_list : Array) -> void:
	player_combatants = player_list
	enemy_combatants = enemy_list
	start_new_player_turn()
	
func deactivate_battle_logic() -> void:
	player_combatants.clear()
	enemy_combatants.clear()
	current_combat_turn = combat_turns.INACTIVE

func start_new_player_turn() -> void:
	player_turn_logic.start_player_turn(player_combatants)
	current_combat_turn = combat_turns.PLAYER_TURN
	generate_mana_at_turn_start()

func start_new_enemy_turn() -> void:
	current_combat_turn = combat_turns.ENEMY_TURN
	enemy_turn_logic.start_enemy_turn()

func initiate_attack() -> void:
	if current_combat_turn == combat_turns.PLAYER_TURN:
		player_turn_logic.initiate_basic_attack()
	
	
func initiate_skill() -> void:
	if current_combat_turn == combat_turns.PLAYER_TURN:
		player_turn_logic.open_skill_menu()
		
func open_item_menu() -> void:
	if current_combat_turn == combat_turns.PLAYER_TURN:
		pass

func execute_attack(attacking_actor : base_actor_combatant, targeted_actor : base_actor_combatant, skill_ability : combat_skill_resource) -> void:
	pass
	
func validate_skill_cost(skill_ability : combat_skill_resource) -> bool:
	var overdraw_flag : bool = false
	
	var current_wrath : int = combat_mana.wrath
	var current_tranquility : int = combat_mana.tranquility
	var current_bravery : int = combat_mana.bravery
	
	var wrath_cost : int = skill_ability.wrath_cost
	var tranquility_cost : int = skill_ability.tranqulity_cost
	var bravery_cost : int = skill_ability.bravery_cost
	
	var mana_projections = {
		"wrath" : current_wrath - wrath_cost,
		"tranquility" : current_tranquility - tranquility_cost,
		"bravery" : current_bravery - bravery_cost
	}
	
	for projection : int in mana_projections.values():
		if projection < 0:
			overdraw_flag = true
		else:
			pass
	 
	return overdraw_flag

func generate_mana_at_turn_start() -> void:
	var generated_wrath : int = 0
	var generated_tranquility: int = 0
	var generated_bravery : int = 0
	
	for player: base_actor_combatant in player_combatants:
		generated_wrath += player.stat_block.combat_wrath_generation
		generated_tranquility += player.stat_block.combat_bravery_generation
		generated_bravery += player.stat_block.combat_bravery_generation
		
	combat_mana.wrath += generated_wrath
	combat_mana.tranquility += generated_tranquility
	combat_mana.bravery += generated_bravery
	print_debug(combat_mana.wrath, combat_mana.tranquility, combat_mana.bravery)

func expend_mana() -> void:
	
	pass
