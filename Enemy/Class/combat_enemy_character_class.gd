class_name combat_enemy_character extends Node2D

var overworld_counterpart : enemy_character 
@export var unit_name : String
@export var unit_description : String
@export var stat_block : enemy_stat_block_resource

@export var attack_pool : Array[base_enemy_attack_structure]
@export var limbs : Array[Sprite2D]
@export var body_part_handler : body_part_handler_component


signal executed_attack(target: combat_player_character, attack_damage: int, attack_type: StringName, combat_description: String)

func _choose_target(player_pool : Array) -> combat_player_character:
	var weakest_player : combat_player_character = player_pool[0]
	for player : combat_player_character in player_pool:
		if player.stat_block.HP < weakest_player.stat_block.HP:
			weakest_player = player
	return weakest_player
	
func _choose_attack(target: combat_player_character) -> base_enemy_attack_structure:
	var selected_attack : base_enemy_attack_structure = attack_pool.pick_random()
	return selected_attack
	
func execute_turn(player_pool: Array) -> void:
	var target = _choose_target(player_pool)
	var attack_stats : base_enemy_attack_structure = _choose_attack(target)
	var attack_damage : int = attack_stats.attack_damage + stat_block.ATK
	var attack_description : String = attack_stats.attack_description
	var attack_type : StringName = attack_stats.attack_type
	
	executed_attack.emit(target, attack_damage, attack_type, attack_description)
