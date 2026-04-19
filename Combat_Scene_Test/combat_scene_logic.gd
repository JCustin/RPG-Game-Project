extends Node2D

var enemy_turn = enemy_turn_logic.new(self)
var player_turn = player_turn_logic.new(self)

var acting_player: Node2D
var active_players_in_combat : Array
var players_acted_this_turn : Array
var player_choosing_target : bool = false

var front_facing_enemy_parts_in_combat: Array
var rear_facing_enemy_parts_in_combat: Array

var potential_enemy_targets : Array
var potential_enemy_target_index: int = 0
var target_enemy : Node2D

var primary_enemy: Node2D

var forward_combat_direction : bool = true # true means front, false means rear

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
	
	primary_enemy = primary_enemy.combat_scene.instantiate()
	%Enemy_Actors.add_child(primary_enemy)
	primary_enemy.attack.connect(execute_attack_calculation)
	
	print_debug(primary_enemy)
	
	acting_player = active_players_in_combat[0]
	spawn_and_position_actors()
	#target_enemy = potential_enemy_targets[0]
	
func spawn_and_position_actors():
	acting_player.position = Vector2(200, -50)
	primary_enemy.scale = Vector2(2,2)
	primary_enemy.position = Vector2(-75, 0)
	pass
	
func _on_attack_pressed() -> void:
	potential_enemy_targets = enemy_turn.return_active_enemy_parts(forward_combat_direction, primary_enemy)
	target_enemy = potential_enemy_targets[0]
	player_turn.highlight_enemy(target_enemy)
	
	for button in %GUI.get_children():
		button.disabled = true
		button.visible = false
	
	player_choosing_target = true
	
func _input(event: InputEvent) -> void:
	if player_choosing_target == true:
		if Input.is_action_just_pressed("ui_left"):
			if (potential_enemy_target_index - 1) < 0:
				player_turn.unhighlight_enemy(target_enemy)
				potential_enemy_target_index = (potential_enemy_targets.size() - 1)
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_turn.highlight_enemy(target_enemy)
				
			elif (potential_enemy_target_index - 1) >= 0:
				player_turn.unhighlight_enemy(target_enemy)
				potential_enemy_target_index -= 1
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_turn.highlight_enemy(target_enemy)
				
		if Input.is_action_just_pressed("ui_right"):
			if potential_enemy_targets.size() > (potential_enemy_target_index + 1):
				player_turn.unhighlight_enemy(target_enemy)
				potential_enemy_target_index += 1
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_turn.highlight_enemy(target_enemy)
				
			elif potential_enemy_targets.size() <= (potential_enemy_target_index + 1):
				player_turn.unhighlight_enemy(target_enemy)
				potential_enemy_target_index = 0
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_turn.highlight_enemy(target_enemy)
				
		if Input.is_action_just_pressed("ui_accept"):
			player_choosing_target = false
			player_turn.unhighlight_enemy(target_enemy)
			acting_player.basic_attack(target_enemy)

func execute_attack_calculation(target: Node2D, attack_value: int, attack_description: String):
	print_debug(attack_description)
	players_acted_this_turn.append(acting_player)
	continue_or_end_player_turn()
	
	pass

func continue_or_end_player_turn():
	var player_index = active_players_in_combat.find(acting_player)
	if players_acted_this_turn.has(acting_player):
		if players_acted_this_turn.size() > (player_index + 1):
			acting_player = players_acted_this_turn[player_index + 1]
			
			for button in %GUI.get_children():
				button.disabled = false
				button.visible = false
				
		elif players_acted_this_turn.size() <= (player_index + 1):
			enemy_turn.start_enemy_turn(primary_enemy, active_players_in_combat)
			pass
	pass

	
func start_enemy_turn():
	enemy_turn.start_enemy_turn(primary_enemy, active_players_in_combat)
	
func start_player_turn():
	print_debug("Should be my turn now")
	players_acted_this_turn.clear()
	acting_player = active_players_in_combat[0]
	for button in %GUI.get_children():
		button.disabled = false
		button.visible = true
		
		
	
func end_combat():
	pass
