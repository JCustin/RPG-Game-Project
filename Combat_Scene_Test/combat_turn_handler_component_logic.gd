class_name combat_turn_handler_component extends Resource


#func _ready() -> void:
	#_connect_signals()

var turn_queue : Array

var active_actor : Node2D

#func _connect_signals() -> void:
	#%Player_Turn_Component.player_turn_ended.connect(continue_or_end_turn)
	#%Player_Turn_Component.player_choosing_target.connect(
		#func():
			#var enemy : combat_enemy_character = enemy_actor_manager.get_child(0)
			#
			#)
		##func():
			##var enemy 
			 ##
			##%Player_Turn_Component.receive_available_targets(%Enemy_Actors.get_child(0).))
	#
	#%Enemy_Turn_Component.enemy_turn_ended.connect(continue_or_end_turn)

func get_turn_queue(turn_queue_array : Array) -> void:
	turn_queue = turn_queue_array
	
func start_turn():
	active_actor = turn_queue[0]
	if active_actor is combat_enemy_character:
		pass
	if active_actor is combat_player_character:
		pass
	
func continue_or_end_turn():
	var current_turn_queue_index: int = turn_queue.find(active_actor)
	var next_turn_queue_index: int = current_turn_queue_index + 1
	
	if turn_queue.size() >= next_turn_queue_index:
		active_actor = turn_queue[next_turn_queue_index]
	else:
		active_actor = turn_queue[0]
