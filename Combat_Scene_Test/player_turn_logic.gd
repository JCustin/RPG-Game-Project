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
	var animplayer = AnimationPlayer.new()
	var enemy_path = enemy.get_path()
	enemy_path = String(enemy_path) + ":modulate"
	print_debug(enemy_path)
	var highlight_animation = Animation.new()
	highlight_animation.loop_mode = Animation.LOOP_LINEAR
	highlight_animation.length = 1.0
	var track_index = highlight_animation.add_track(Animation.TYPE_VALUE)
	highlight_animation.track_set_path(track_index, enemy_path)
	highlight_animation.track_insert_key(track_index, 0.00, Color(100,100,100))
	highlight_animation.track_insert_key(track_index, 1.00, Color(100,100,100))
	highlight_animation.track_insert_key(track_index, 0.50, Color(0, 10, 100, 50))
	var short_animation_name : String = "highlight_enemy"
	var full_animation_name : String = "animation_library" + "\\" + short_animation_name
	
	animation_library.add_animation("highlight_enemy", highlight_animation)
	animplayer.play(full_animation_name)
	
	
	
	
func kill_player(player: Node2D):
	# TODO write code for killing a player 
	# unit when hp >= 0
	pass
