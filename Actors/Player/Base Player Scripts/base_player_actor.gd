class_name base_player_actor extends base_actor_class
@export var texture : base_actor_texture_component

# handle_movement
func _physics_process(delta: float) -> void:
# MOVEMENT
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	
	#TODO code edge cases where multiple inputs are 
	# entered simultaneously. Such as Vector(1,1)	
	match input_dir:
		Vector2.UP:
			texture.play("Walk North")
		Vector2.DOWN:
			texture.play("Walk South")
		Vector2.LEFT:
			texture.play("Walk West")
		Vector2.RIGHT:
			texture.play("Walk East")
		Vector2.ZERO:
			texture.play("Idle")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stat_block.movement_speed
		velocity.z = direction.z * stat_block.movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, stat_block.movement_speed)
		velocity.z = move_toward(velocity.z, 0, stat_block.movement_speed)

	move_and_slide()
