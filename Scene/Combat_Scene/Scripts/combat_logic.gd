extends Node2D

var combat_description_open: bool = false
signal combat_end

func _ready() -> void:
	%Player_Turn.fled_combat.connect(end_combat)
	%Player_Turn.prompt_combat_description.connect(prompt_combat_description)
	#%Player_Turn.player_turn_ended.connect(start_enemy_turn)
	#%Enemy_Turn.enemy_turn_ended.connect(end_enemy_turn)
	
	for player in get_tree().get_nodes_in_group('Player'):
		var player_combat_counterpart = player.combat_unit_counterpart.instantiate()
		%Actors.add_child(player_combat_counterpart)
		%Player_Turn.player_queue += [player_combat_counterpart]
		player_combat_counterpart.attack.connect(handle_attack) #TODO find better naming scheme
		
	for enemy in get_tree().get_nodes_in_group('Combat_Enemies'):
		var enemy_combat_counterpart = enemy.combat_unit_counterpart.instantiate()
		%Actors.add_child(enemy_combat_counterpart)
		%Enemy_Turn.enemy_queue += [enemy_combat_counterpart]
		
		enemy_combat_counterpart.attack.connect(handle_attack)
		
	%Player_Turn.start_player_turn()

func handle_attack(target, attack_value, attack_description):
	await prompt_combat_description(attack_description)
	#target.health_stat -= attack_value
	#print(target, target.health_stat)
	#TODO expand this to accomodate for DEF and resistances. 

func prompt_combat_description(description):
	%Combat_Text.text = description
	%Combat_Description.visible = true
	combat_description_open = true
	#await get_tree().create_timer(2.00).timeout
	#if combat_description_open == true:
		#close_prompt_description()
	
func close_prompt_description():
	%Combat_Description.visible = false

func end_combat():
	combat_end.emit()
	get_parent().queue_free()

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and combat_description_open == true:
		combat_description_open = false
		close_prompt_description()

#func start_enemy_turn():
	#%Enemy_Turn.start_turn()
	#
#func end_enemy_turn():
	#%Player_Turn.start_player_turn()
