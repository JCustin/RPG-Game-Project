extends Node
class_name player_turn_logic

var animation_library = AnimationLibrary.new()

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
	
func _ready() -> void:
	acting_player = player_queue[0]
	
func update_enemy_queue(enemy_queue_dict: Dictionary):
	enemy_queue = enemy_queue_dict.values()


func continue_or_end_turn():
	if players_acted_this_turn.has(acting_player):
		if player_queue.size() > (acting_player_index + 1):
			acting_player = player_queue[acting_player_index + 1]
		else:
			parent_script.end_player_turn()
			

func trigger_target_select(potential_enemy_targets: Array):
	
	player_choosing_target = true
	enemy_queue = potential_enemy_targets
	target_enemy = enemy_queue[0]
			
func highlight_enemy(enemy):
	var tween = create_tween()
	tween.tween_property(enemy, "modulate", Color(2.224, 2.224, 2.224), 2.0)
	
	
	
	#var tween = create_tween()
	#tween.set_loops()
	#tween.tween_property(enemy, "modulate:v", Color(2.224, 2.224, 2.224), 2.0)
	#tween.tween_property(enemy, "modulate:v", Color(10, 20, 30, 0), 2.0)	
	
	print_debug(enemy)
	enemy.modulate = Color(100, 0, 40)
	#var tween = create_tween()
	#tween.tween_property(enemy, "modulate:v", 1, 0.25).from(15)
	pass
	
func unhighlight_enemy(enemy):
	enemy.modulate = Color(1.0, 1.0, 1.0)
	
func kill_player(player: Node2D):
	# TODO write code for killing a player 
	# unit when hp >= 0
	pass
