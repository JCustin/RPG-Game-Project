class_name combat_manager extends Node

# will receive signal from Actor Manager to initiate combat
@export var actor_manager_component : actor_manager
@export var player_center_position : Node3D
@export var player_left_position : Node3D
@export var player_right_position : Node3D
@export var enemy_central_position : Node3D
@export var battle_camera : Camera3D
@export var battle_view : SubViewportContainer
@export var combat_logic : battle_logic_manager

enum combat_state {PLAYER, ENEMY,}



func _ready() -> void:
	await get_parent().ready
	%Attack_Button.pressed.connect(process_attack)
	%Skill_Button.pressed.connect(process_skill_attack)
	
	actor_manager_component.initiate_combat.connect(start_battle)
	
func start_battle(player_party: Array[base_player_actor], surrounding_enemies: Array[base_enemy_actor]) -> void:
	# first step is to extract the combat counterpart for each actor. Start with players, then enemies
	
	var player_combatants : Array[base_player_combatant]
	
	for player : base_player_actor in player_party:
		var combatant : base_actor_combatant = player.stat_block.basic_combat_unit.instantiate()
		
		player_combatants.append(combatant)
		add_child(combatant)
		combatant.reparent(player_right_position)
		combatant.assign_stat_block(player)
		combatant.position = get_parent().position
		
	var enemy_combatants : Array[base_enemy_combatant]
	
	for enemy : base_enemy_actor in surrounding_enemies:
		var combatant : base_actor_combatant = enemy.stat_block.basic_combat_unit.instantiate()
		
		enemy_combatants.append(combatant)
		add_child(combatant)
		combatant.reparent(enemy_central_position)
		combatant.assign_stat_block(enemy)
		combatant.position = get_parent().position
		
	combat_logic.activate_battle_logic(player_combatants, enemy_combatants)

	# activate the battle camera
	battle_camera.make_current()
	battle_view.visible = true
	
# combat_menu button handling
func process_attack():
	combat_logic.initiate_attack()
	
func process_skill_attack():
	combat_logic.initiate_skill()
	
func process_item_menu():
	combat_logic.open_item_menu()

func process_flee():
	combat_logic.flee()


	
