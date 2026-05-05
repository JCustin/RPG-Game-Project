extends Node
var AI_wandering : bool = false
var recorded_velocity: Vector2

var ms_spent_wandering : int = 0
var wander_reset_threshold : int = 30

func _find_direction() -> Vector2:
	var possible_directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.UP]
	return possible_directions.pick_random()

func _determine_velocity(direction: Vector2) -> Vector2:
	var possible_speed = [
		100, 
		300,
	]
	var selected_velocity = possible_speed.pick_random()
	var velocity = selected_velocity * direction
	return velocity 
	
func handle_movement() -> Vector2:
	if AI_wandering == false:
		
		AI_wandering = true
		var wander_direction = _find_direction()
		recorded_velocity = _determine_velocity(wander_direction)
		
		if ms_spent_wandering <= wander_reset_threshold:
			ms_spent_wandering += 1
			return recorded_velocity
			
		else:
			AI_wandering = false
			return Vector2.ZERO
			
	else:
		return recorded_velocity
		
