class_name combat_enemy_turn_component extends Node

signal enemy_turn_ended

func choose_target(list_of_potential_targets: Array) -> combat_player_character:
	var weakest_target : combat_player_character = list_of_potential_targets[0]
	
	for target: combat_player_character in list_of_potential_targets:
		if target.stat_block.HP < weakest_target.stat_block.HP:
			weakest_target = target
		else:
			pass
	
	return weakest_target
