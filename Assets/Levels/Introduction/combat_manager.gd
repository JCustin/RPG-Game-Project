class_name combat_manager_component extends Node

var combat_scene : base_combat_scene
signal combat_won
signal combat_lost

	
#func start_combat(inciting_enemy : enemy_actor_class):
	#var enemies : Array[enemy_actor_class] = [inciting_enemy]
	#combat_scene = base_combat_scene.new()
	#combat_pull_radius.position = inciting_enemy.position
	#
	## find all players in party
	#var players : Array[player_actor_class]
	#for child in player_actor_manager.get_children():
		#if child is player_actor_class:
			#players.append(child)
	#
	#
	## code to check if other enemies are in the 
	## combat_pull_radius below - TODO
	#var local_enemies : Array[enemy_actor_class]
	#local_enemies.append(inciting_enemy)
	## execute combat scene
	#
	#
	#add_child(combat_scene)
	#combat_scene.init_combat(players, local_enemies)
	##combat_scene.init_combat(players, enemies)

	
#var combat_scene : combat_scene_class
#
#signal combat_over
#signal player_killed
#
#var overworld_enemy : enemy_character
#var overworld_player: player_character
#
#
#func initiate_combat(player_initiating_combat: player_character, enemy_initiating_combat: enemy_character):
	#overworld_enemy = enemy_initiating_combat
	#overworld_player = player_initiating_combat
	#
	#combat_scene = load("uid://buylh0rmqi1ll").instantiate()
	#if combat_scene.is_visible_in_tree():
		#return
	#add_child(combat_scene)
	#combat_scene.z_index = 1000
	#combat_scene.cust_init(player_initiating_combat, enemy_initiating_combat)
	#
	#`.combat_won.connect(end_combat_win)
	#combat_scene.combat_fled.connect(end_combat_fled)
	#combat_scene.combat_fled.connect(player_defeated)
	#
	#for inventory_node : inventory_gui in get_tree().get_nodes_in_group('Inventory'):
		#inventory_node.free_inventory()
	#
	#
#func end_combat_win():
	#overworld_enemy.free()
	#Player_Data.combat_ended.emit()
	#combat_scene.queue_free()
	#
#func end_combat_fled():
	#Player_Data.combat_ended.emit()
	#combat_scene.queue_free()
	#overworld_enemy.stun_after_combat()
	#
#func player_defeated():
	#pass
#
