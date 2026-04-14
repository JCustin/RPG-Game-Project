extends Node
var player_turn: bool
var player_choosing_target: bool

var acting_player: Node2D
var player_index : int = 0 
var players_acted_this_turn: Array

var target_enemy_index: int = 0
var target_enemy: Node2D

var player_queue: Array

signal fled_combat
signal prompt_combat_description(text: String)
signal player_turn_ended()

func _ready() -> void:
	player_turn = true
	player_choosing_target = false

func start_player_turn():
	player_index = 0 
	acting_player = player_queue[player_index]
	player_turn = true
	player_choosing_target = false
	for button in %Action_Panel_Button_Container.get_children():
		button.disabled = false

func continue_or_end_player_turn():
	if players_acted_this_turn.has(acting_player):
		if player_queue.size() > (player_index + 1):
			acting_player = player_queue[player_index + 1]
		else:
			player_turn = false
			
			#await get_tree().create_timer(2.0).timeout
			player_turn_ended.emit()
			for button in %Action_Panel_Button_Container.get_children():
				button.disabled = true


func _on_attack_pressed() -> void:
	if player_turn == true:
		start_choosing_target()
	else:
		pass

func start_choosing_target():
	%Action_Panel.visible = false
	for button in %Action_Panel_Button_Container.get_children():
		button.disabled = true
	
	var enemy_queue = %Enemy_Turn.enemy_queue 
	target_enemy = enemy_queue[target_enemy_index]
	
	player_choosing_target = true
	highlight_target_enemy(target_enemy)
	
func attack_target():
	%Action_Panel.visible = true
	for button in %Action_Panel_Button_Container.get_children():
		button.disabled = false
	player_choosing_target = false
	stop_highlighting_target_enemy(target_enemy)
	acting_player.basic_attack(target_enemy)
	players_acted_this_turn += [acting_player]
	continue_or_end_player_turn()

func _input(event: InputEvent) -> void:
	var enemy_queue = %Enemy_Turn.enemy_queue
	if Input.is_action_just_pressed("ui_left") and player_choosing_target == true: # logic checks if there even is an item BEFORE the current index. 
		if enemy_queue.size() > (target_enemy_index - 1):
			target_enemy = enemy_queue[target_enemy_index - 1]
			highlight_target_enemy(target_enemy)
		else:
			target_enemy = enemy_queue[-1] # if there is not an item before the current item, go to the last enemy
			highlight_target_enemy(target_enemy)

			
	if Input.is_action_just_pressed("ui_right") and player_choosing_target == true: # logic checks if there is an item AFTER the current index
		if enemy_queue.size() > (target_enemy_index + 1):
			target_enemy = enemy_queue[target_enemy_index + 1]
			highlight_target_enemy(target_enemy)
		else:
			target_enemy = enemy_queue[0] # if  there is not an item after the current item, go to the first enemy
			highlight_target_enemy(target_enemy)
			
	if Input.is_action_just_pressed("ui_accept") and player_choosing_target == true:
		#attack_target()
		prompt_combat_description.emit("TEST")

func _on_run_pressed() -> void:
	if player_turn == true and %Combat_Description.visible == false:
		var flee_roll_threshold = 50
		var flee_attempt_roll = randi_range(1, 100)
		if flee_attempt_roll > flee_roll_threshold:
			prompt_combat_description.emit('You fled!')
			await get_tree().create_timer(1.5).timeout
			fled_combat.emit()
		else:
			prompt_combat_description.emit('You failed to flee!')
	pass # Replace with function body.
	
func highlight_target_enemy(enemy):
	enemy.modulate = Color(12, 0, 149)
	
	pass

func stop_highlighting_target_enemy(enemy):
	enemy.modulate = Color(1.0, 1.0, 1.0)
	pass

	
