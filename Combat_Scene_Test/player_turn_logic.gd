extends Node
class_name player_turn_logic

var parent_script : Node2D

var player_choosing_target: bool = false
var target_enemy: Node2D 

var enemy_queue : Array
var enemy_queue_index : int

var acting_player: Node2D
var player_queue: Array

var acting_player_index: int
var players_acted_this_turn: Array

func _init(parent_script_node: Node2D) -> void:
	parent_script = parent_script_node
	
func update_enemy_queue(enemy_queue_dict: Dictionary):
	enemy_queue = enemy_queue_dict.values()

func _input(event: InputEvent) -> void:
	if player_choosing_target == false:
		if Input.is_key_pressed(KEY_BACKSPACE):
			parent_script.end_player_combat()
	
	if player_choosing_target == true:
		if Input.is_action_just_pressed("ui_left"):
			if (enemy_queue_index - 1) < 0:
				enemy_queue_index = 0
				target_enemy = enemy_queue[enemy_queue_index]
			elif (enemy_queue_index - 1) > 0:
				enemy_queue_index -= 1
				target_enemy = enemy_queue[enemy_queue_index]
				
		if Input.is_action_just_pressed("ui_right"):
			if enemy_queue.size() > (enemy_queue_index + 1):
				enemy_queue_index += 1
				target_enemy = enemy_queue[enemy_queue_index]
			elif enemy_queue.size() < (enemy_queue_index + 1):
				enemy_queue_index = 0
				target_enemy = enemy_queue[enemy_queue_index]
			if enemy_queue.size() > (enemy_queue_index - 1):
				enemy_queue 

func continue_or_end_turn():
	if players_acted_this_turn.has(acting_player):
		if player_queue.size() > (acting_player_index + 1):
			acting_player = player_queue[acting_player_index + 1]
		else:
			parent_script.end_player_turn()
			
			
func kill_player(player: Node2D):
	# TODO write code for killing a player 
	# unit when hp >= 0
	pass
