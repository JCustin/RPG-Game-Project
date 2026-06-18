class_name ai_pathfinder extends NavigationAgent2D

@export var actor_owner : enemy_character
@export var ai_movement_behavior_controller : ai_movement_controller

var moving_to_target_flag : bool = false

# the ai_movement_contoller exclusively handles the 
# pathfinding aspect of ai_movement. It does not handle
# movement behaviors and target selection


func _physics_process(delta: float) -> void:
	if moving_to_target_flag == false:
		target_position = ai_movement_behavior_controller._find_target_position()
		print_debug(target_position)
		moving_to_target_flag = true
		
	var direction = actor_owner.global_position.direction_to(target_position)
	actor_owner.velocity = direction * 100
	actor_owner.move_and_slide()

	if actor_owner.global_position.round() == target_position:
		moving_to_target_flag = false
