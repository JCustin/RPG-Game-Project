class_name base_combat_scene extends Node3D

@export var background_image : CompressedTexture2D
var combat_players : Array[combat_player_character]
var combat_enemies : Array[combat_enemy_character]
@export var camera : Camera3D

var location_manager : combat_location_manager

func init_combat(players : Array[player_actor_class], enemies: Array[enemy_actor_class]):
	for child in get_children():
		if child is combat_location_manager:
			location_manager = child
		else:
			pass
	
	#for player in players:
		#combat_players.append(player.stat_block.combat_counterpart)
	#for enemy in enemies:
		#combat_enemies.append(enemy.stat_block.combat_counterpart)
		
	#location_manager.define_position_map()
		
# TODO FINISH THE REST OF THE COMBAT LOGIC
