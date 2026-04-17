extends Node2D

var enemy_turn = enemy_turn_logic.new(self)
var player_turn = player_turn_logic.new(self)

var acting_player: Node2D
var active_players_in_combat : Array

var front_facing_enemy_parts_in_combat: Array
var rear_facing_enemy_parts_in_combat: Array

var primary_enemy: Node2D

func custom_initialize(enemy: Node2D):
	primary_enemy = enemy
	#TODO this function needs to pass through the background
	# and then apply from the parent level node.

func _ready() -> void:
	for player in get_tree().get_nodes_in_group('Player'):
		var player_combat_scene = player.combat_scene.instantiate()
		%Player_Actors.add_child(player_combat_scene)
		player_combat_scene.attack.connect(execute_attack_calculation)
		active_players_in_combat += [player_combat_scene]
		
	#active_players_in_combat = get_tree().get_nodes_in_group('Players')
	
	primary_enemy = primary_enemy.combat_scene.instantiate()
	%Enemy_Actors.add_child(primary_enemy)
	primary_enemy.attack.connect(execute_attack_calculation)
	
	enemy_turn.set_primary_enemy(primary_enemy)	
	
	acting_player = active_players_in_combat[0]
	spawn_and_position_actors()
	#player_turn.start_player_turn()
	
func spawn_and_position_actors():
	acting_player.position = Vector2(200, -50)
	print(primary_enemy)
	primary_enemy.scale = Vector2(2,2)
	primary_enemy.position = Vector2(-75, 0)
	pass
	
func execute_attack_calculation(target: Node2D, attack_value: int, attack_description: String):
	
	pass
	
func end_combat():
	pass

func end_player_combat():
	enemy_turn.start_enemy_turn()
