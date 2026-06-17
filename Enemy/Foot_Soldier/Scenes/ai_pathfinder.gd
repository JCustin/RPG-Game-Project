class_name ai_pathfinder extends NavigationAgent2D

@export var actor_owner : enemy_character
var target_selected_flag : bool = false

# the ai_movement_contoller exclusively handles the 
# pathfinding aspect of ai_movement. It does not handle
# movement behaviors and target selection
func _ready() -> void:
	var player = get_tree().get_first_node_in_group('Player')
	

#func assign_target_position(position: Vector2) -> void:
	#target_position = position
	#target_selected_flag = true
	
func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group('Player')
	target_position = player.global_position
	var direction = actor_owner.global_position.direction_to(target_position)
	actor_owner.velocity = direction * 50
	actor_owner.move_and_slide()
	print_debug(get_path_length())
	
