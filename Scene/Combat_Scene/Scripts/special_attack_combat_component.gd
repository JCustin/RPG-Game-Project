class_name special_attack_combat_component extends Node

var special_attack_menu : ItemList
var special_attack_pool : Array[special_attack_stat_block]
var special_attack_panel : Panel

var target_selector : combat_target_selection_logic
var target_pool : Array

var chosen_special_attack : special_attack_stat_block

signal execute_special_attack(
	target, 
	attack_damage: int, 
	damage_type: global_enums.damage_type, 
	attack_description: String
)

func _init(active_actor: combat_player_character, special_attack_list : ItemList, enemy_limbs: Array) -> void:
	print_debug(target_pool)
	target_pool = enemy_limbs
	special_attack_menu = special_attack_list	
	special_attack_pool = active_actor.player_special_attacks_pool
	special_attack_panel = special_attack_menu.get_parent()
	_open_special_attack_menu()
	connect_signals()
	
func connect_signals() -> void:
	special_attack_menu.item_activated.connect(select_special_attack.call_deferred)
	
func _open_special_attack_menu() -> void:
	special_attack_panel.visible = true
	#special_attack_menu.focus_mode = Control.FOCUS_ALL
	
	for special_attack in special_attack_pool:
		var special_attack_name = special_attack.attack_name
		
		#var special_attack_data = {
			#"attack_damage": special_attack.attack_damage,
			#"damage_type": special_attack.damage_type,
			#"attack_description": special_attack.attack_description,
			#"applicable_weapon_types": special_attack.applicable_weapon_types,
			#"attack_name" : special_attack.attack_name,
			#"STAM_cost" : special_attack.STAM_cost
		#}
		
		var list_index = special_attack_menu.add_item(special_attack_name)
		special_attack_menu.set_item_metadata(list_index, special_attack)
		print_debug(special_attack_menu.get_item_metadata(list_index))
	
func select_special_attack(index):
	#print_debug(index, ' ', special_attack_menu.item_count)
	chosen_special_attack = special_attack_menu.get_item_metadata(index)
	target_selector = combat_target_selection_logic.new(target_pool)
	add_child(target_selector)
	
	special_attack_panel.visible = false
	special_attack_menu.deselect_all()
	special_attack_menu.clear()
	
	target_selector.target_selected.connect(
		func(target): 
		execute_special_attack.emit(target, 
		chosen_special_attack.attack_damage, 
		chosen_special_attack.damage_type,
		chosen_special_attack.attack_description)
		)
		
	target_selector.target_selection_aborted.connect(
		func():
		queue_free()
		)
	
