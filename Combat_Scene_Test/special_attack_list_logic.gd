class_name special_attack_list_component extends ItemList

func retrieve_special_attacks(active_actor : combat_player_character) -> void:
	var special_attack_pool = active_actor.player_special_attacks_pool
	for special_attack: special_attack_stat_block in special_attack_pool:
		var index = add_item(special_attack.attack_name)
		set_item_metadata(index, special_attack)
	
