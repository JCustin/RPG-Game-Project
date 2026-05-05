extends enemy_character
@export var movement_controller : ai_movement_controller

#var possible_behaviors : Array
func _physics_process(_delta: float) -> void:
	velocity = movement_controller.get_velocity()
	move_and_slide()
	print_debug(velocity)
	
	
