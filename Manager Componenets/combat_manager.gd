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
@export var combat_menu : VBoxContainer

enum combat_state {PLAYER, ENEMY,}



func _ready() -> void:
	await get_parent().ready
	%Attack_Button.pressed.connect(process_attack)
	%Skill_Button.pressed.connect(process_skill_attack)
	combat_logic.attack_canceled.connect(enable_combat_menu)
	combat_logic.attack_launched.connect(disable_combat_menu)
	
	actor_manager_component.initiate_combat.connect(start_battle)
	
func start_battle(player_party: Array[base_player_actor], surrounding_enemies: Array[base_enemy_actor]) -> void:
	# first step is to extract the combat counterpart for each actor. Start with players, then enemies
	
	var player_combatants : Array[base_player_combatant]
	
	for player : base_player_actor in player_party:
		player_combatants.append(player.stat_block.basic_combat_unit.instantiate())
	
	var enemy_combatants : Array[base_enemy_combatant]
	for enemy : base_enemy_actor in surrounding_enemies:
		enemy_combatants.append(enemy.stat_block.basic_combat_unit.instantiate())
		
	combat_logic.activate_battle_logic(player_combatants, enemy_combatants)
	
	# after the combat counterpart is extracted, it is added as a child of combat_manager
	for player : base_player_combatant in player_combatants:
		add_child(player)
		player.reparent(player_right_position)
		player.position = get_parent().position
		
	for enemy : base_enemy_combatant in enemy_combatants:
		add_child(enemy)
		enemy.reparent(enemy_central_position)
		enemy.position = get_parent().position
		
	
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

# combat_menu disabling handling	
func disable_combat_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = true
		
func enable_combat_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = false
