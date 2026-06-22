class_name attack_damage_handler_component extends Node

func calculate_attack(attacker, target, attack_damage: global_enums.damage_type, attack_type: int) -> int:
	if target is enemy_limb_class:
		
		var target_limb : enemy_limb_class = target
		var limb_defense = target_limb.stat_block.DEF
		var limb_HP = target_limb.stat_block.HP
		var limb_weakness = target_limb.stat_block.damage_type_weakness
		var remaining_attack = attack_damage - limb_defense
		print_debug('Remaining attack: ', remaining_attack, ' and limb_HP: ', limb_HP)
		
		if remaining_attack <= 0:
			return limb_HP
		
		if attack_type == limb_weakness:
			attack_damage = int(attack_damage * 1.25)
			
		var new_HP = limb_HP - remaining_attack
		print_debug(new_HP)
		return new_HP
	
	else:
		
		var target_player : combat_player_character = target
		var player_defense = target_player.stat_block.DEF
		var player_HP = target_player.stat_block.HP
		var remaining_attack = attack_damage - player_defense
		
		if remaining_attack <= 0:
			return player_HP
		
		var new_HP = player_HP - remaining_attack
		return new_HP
