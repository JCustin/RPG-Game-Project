class_name base_player_actor extends base_actor_class

# handle_movement
func _physics_process(delta: float) -> void:
# MOVEMENT
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stat_block.movement_speed
		velocity.z = direction.z * stat_block.movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, stat_block.movement_speed)
		velocity.z = move_toward(velocity.z, 0, stat_block.movement_speed)

	if Input.is_key_pressed(KEY_SPACE):
		pass
		
	move_and_slide()
