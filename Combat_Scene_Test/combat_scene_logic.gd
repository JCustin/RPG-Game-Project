extends Node2D

var enemy_logic = enemy_turn_logic.new(self)
var player_logic = player_turn_logic.new(self)

var acting_player: Node2D
var turn_queue : Array
var player_choosing_target : bool = false

var active_players_in_combat : Array

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
		player_combat_scene.attack.connect(execute_attack)
		active_players_in_combat += [player_combat_scene]
	
	primary_enemy = primary_enemy.combat_scene.instantiate()
	%Enemy_Actors.add_child(primary_enemy)
	primary_enemy.attack.connect(execute_attack)
	active_players_in_combat += [primary_enemy]
	
	turn_queue = %Timeline_System.assign_turn_queue(active_players_in_combat)
	active_players_in_combat = turn_queue
	
	acting_player = turn_queue[0]
	spawn_and_position_actors()
	start_combat_round()
	
func spawn_and_position_actors():
	var first_player_actor: Node2D
	if acting_player == primary_enemy:
		first_player_actor = turn_queue[1]
		print_debug(first_player_actor)
	else:
		first_player_actor = acting_player
		
	first_player_actor.position = Vector2(200, -50)
	primary_enemy.scale = Vector2(2,2)
	primary_enemy.position = Vector2(-75, 0)
	pass
	
func _on_attack_pressed() -> void:
	potential_enemy_targets = enemy_logic.return_active_enemy_parts(forward_combat_direction, primary_enemy)
	target_enemy = potential_enemy_targets[0]
	player_logic.highlight_enemy(target_enemy)
	
	for button in %GUI.get_children():
		button.disabled = true
		button.visible = false
	
	player_choosing_target = true
	
func _input(event: InputEvent) -> void:
	if player_choosing_target == true:
		if Input.is_action_just_pressed("ui_left"):
			if (potential_enemy_target_index - 1) < 0:
				player_logic.unhighlight_enemy(target_enemy)
				potential_enemy_target_index = (potential_enemy_targets.size() - 1)
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_logic.highlight_enemy(target_enemy)
				
			elif (potential_enemy_target_index - 1) >= 0:
				player_logic.unhighlight_enemy(target_enemy)
				potential_enemy_target_index -= 1
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_logic.highlight_enemy(target_enemy)
				
		if Input.is_action_just_pressed("ui_right"):
			if potential_enemy_targets.size() > (potential_enemy_target_index + 1):
				player_logic.unhighlight_enemy(target_enemy)
				potential_enemy_target_index += 1
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_logic.highlight_enemy(target_enemy)
				
			elif potential_enemy_targets.size() <= (potential_enemy_target_index + 1):
				player_logic.unhighlight_enemy(target_enemy)
				potential_enemy_target_index = 0
				target_enemy = potential_enemy_targets[potential_enemy_target_index]
				player_logic.highlight_enemy(target_enemy)
				
		if Input.is_action_just_pressed("ui_accept"):
			player_choosing_target = false
			player_logic.unhighlight_enemy(target_enemy)
			acting_player.basic_attack(target_enemy)

func execute_attack(target: Node2D, attack_value: int, attack_description: String):
	await prompt_combat_description(attack_description)
	
	if target == primary_enemy:
		pass
		
	else:
		pass
		
	proceed_with_turn_queue()

func prompt_combat_description(attack_description: String) -> void:
	var combat_label = Label.new()
	%Combat_Description_Panel.add_child(combat_label)
	combat_label.anchor_left
	combat_label.text = attack_description
	
	%Combat_Description_Master.visible = true
	
	await get_tree().create_timer(1.5).timeout
	combat_label.free()
	%Combat_Description_Master.visible = false
	return

func start_enemy_turn():
	enemy_logic.execute_enemy_turn(primary_enemy, turn_queue)
	for button in %GUI.get_children():
		button.disabled = true
		button.visible = false
	
func start_player_turn():
	for button in %GUI.get_children():
		button.disabled = false
		button.visible = true

func end_combat():
	pass

func start_combat_round():
	if acting_player == primary_enemy:
		start_enemy_turn()
	else:
		start_player_turn()


func proceed_with_turn_queue():
	var current_turn_queue_index = turn_queue.find(acting_player)
	var next_turn_queue_index: int = (current_turn_queue_index + 1)
	
	if turn_queue.size() <= (next_turn_queue_index):
		turn_queue = %Timeline_System.refresh_turn_queue(active_players_in_combat)
		acting_player = turn_queue[0]
		start_combat_round()
	else:
		acting_player = turn_queue[next_turn_queue_index]
		check_if_actor_alive(acting_player)
		

func check_if_actor_alive(actor): 
	if actor.alive == true:
		start_combat_round()
	else:
		proceed_with_turn_queue()
