class_name combat_timeline_system extends Resource

var round_count : int = 0
var static_timeline: bool = false
# idea for static_timeline is to handle speed between starting a round vs within a round.
# if static_timeline == true, then speed values greater than 100 are set to 100.
# if static_timeline == false, then speed values that are increased over 100 are now pushed 
# out of the current round and the remainder affects their turn placement next round


@export var maximum_timeline_value : int = 100

func assign_turn_queue(active_actors_in_combat: Array) -> Array:
	var static_timeline = true
	var final_turn_queue : Array
	var actor_speed_turn_queue : Array
	
	for actor in active_actors_in_combat:
		actor_speed_turn_queue.append([actor, (100 - actor.stat_block.SPD)])
		
			
	actor_speed_turn_queue.sort_custom(sort_by_speed)
	
	for index in range(actor_speed_turn_queue.size()):
		var actor = actor_speed_turn_queue[index][0]
		final_turn_queue.append(actor)
	
	static_timeline = false
	return final_turn_queue

func sort_by_speed(a, b):
	if a[1] < b[1]:
		return true
	else:
		return false
		
func refresh_turn_queue(active_players_in_combat: Array): # easier code-wise to tell when we're starting vs refreshing for a new round 
	var turn_queue: Array
	turn_queue = assign_turn_queue(active_players_in_combat)
	round_count += 1 
	return turn_queue
