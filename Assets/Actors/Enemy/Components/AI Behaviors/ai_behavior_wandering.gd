extends Node
var AI_wandering : bool = false
var recorded_velocity: Vector2

var ms_spent_wandering : int = 0
var wander_reset_threshold : int = 60

func _find_direction() -> Vector2:
	var possible_directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.UP]
	return possible_directions.pick_random()

func _determine_velocity(direction: Vector2) -> Vector2:
	var speed = 80
	var velocity = direction * speed
	return velocity
	
func handle_movement() -> Vector2:
	if AI_wandering == false:
		AI_wandering = true
		recorded_velocity = _determine_velocity(_find_direction())
		return recorded_velocity
	
	else: # if AI_wandering == true
		if ms_spent_wandering <= wander_reset_threshold:
			ms_spent_wandering += 1
			return recorded_velocity
		else:
			AI_wandering = false
			ms_spent_wandering = 0 
			recorded_velocity = Vector2.ZERO
			return recorded_velocity
