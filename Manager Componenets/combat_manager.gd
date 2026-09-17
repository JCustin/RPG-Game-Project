class_name combat_manager extends Node

# will receive signal from Actor Manager to initiate combat
@export var actor_manager_component : actor_manager

func _ready() -> void:
	await get_parent().ready
	actor_manager_component.initiate_combat.connect(start_battle)
	
func start_battle(player_party: Array[base_player_actor], surrounding_enemies: Array[base_enemy_actor]) -> void:
	# first step is to extract the combat counterpart for each actor. Start with players, then enemies
	var player_combatants : Array[base_player_combatant]
	
	for player : base_player_actor in player_party:
		player_combatants.append(player.stat_block.combat_unit.instantiate())
	
	var enemy_combatants : Array[base_enemy_combatant]
	for enemy : base_enemy_actor in surrounding_enemies:
		enemy_combatants.append(enemy.stat_block.combat_unit.instantiate())
		
	for enemy : base_enemy_combatant in enemy_combatants:
		add_child(enemy)
		enemy.position = %"Enemy Position 2".position

		
	for player : base_player_combatant in player_combatants:
		add_child(player)
		player.position = %"Player Position 1".position

	%"Battle Camera".make_current()
