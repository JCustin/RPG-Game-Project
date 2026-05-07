class_name combat_turn_handler_component extends Resource
	
func continue_or_end_turn(active_actor: Node2D, turn_queue: Array):
	var current_turn_queue_index: int = turn_queue.find(active_actor)
	var next_turn_queue_index: int = current_turn_queue_index + 1
	
	if turn_queue.size() >= next_turn_queue_index:
		active_actor = turn_queue[next_turn_queue_index]
	else:
		active_actor = turn_queue[0]
		
