class_name combat_manager_component extends Node

var combat_scene : combat_scene_class

signal combat_over
signal player_killed

var overworld_enemy : enemy_character
var overworld_player: player_character


func initiate_combat(player_initiating_combat: player_character, enemy_initiating_combat: enemy_character):
	overworld_enemy = enemy_initiating_combat
	overworld_player = player_initiating_combat
	
	combat_scene = preload("uid://buylh0rmqi1ll").instantiate()
	if combat_scene.is_visible_in_tree():
		return
	add_child(combat_scene)
	combat_scene.z_index = 1000
	combat_scene.cust_init(player_initiating_combat, enemy_initiating_combat)
	
	combat_scene.combat_won.connect(end_combat_win)
	combat_scene.combat_fled.connect(end_combat_fled)
	combat_scene.combat_fled.connect(player_defeated)
	
	for inventory_node : inventory_gui in get_tree().get_nodes_in_group('Inventory'):
		inventory_node.free_inventory()
	
	
func end_combat_win():
	overworld_enemy.free()
	combat_over.emit()
	combat_scene.queue_free()
	
func end_combat_fled():
	combat_over.emit()
	combat_scene.queue_free()
	overworld_enemy.stun_after_combat()
	
func player_defeated():
	pass
