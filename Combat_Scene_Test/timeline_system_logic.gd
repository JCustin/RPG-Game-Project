class_name combat_timeline_system extends Resource

var round_count : int = 0
var static_timeline: bool = false
# idea for static_timeline is to handle speed between starting a round vs within a round.
# if static_timeline == true, then speed values greater than 100 are set to 100.
# if static_timeline == false, then speed values that are increased over 100 are now pushed 
# out of the current round and the remainder affects their turn placement next round


@export var maximum_timeline_value : int = 100

func assign_turn_queue(active_actors_in_combat: Array) -> Array:
	var speed_order : Array 
	var turn_queue : Array 
	
	for actor in active_actors_in_combat:
		print_debug("Actor: ", actor)
		var actor_speed = actor.stat_block.SPD
		var number_of_turns = ceili(actor_speed / 25)
		print_debug(actor, " No of turns: ", number_of_turns)
		if number_of_turns == 0:
			number_of_turns = 1
		
		for action in range(number_of_turns):
			var speed_differentiation = 50 * action
			speed_order.append([actor, (actor_speed + speed_differentiation)])
			
	print_debug("Speed Order: ", speed_order)
	speed_order.sort_custom(sort_by_speed)
	
		
	for index in range(speed_order.size()):
		var actor = speed_order[index][0]
		turn_queue.append(actor)

	return turn_queue

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
