class_name player_actor_class extends base_actor_class

var movement_active : bool = true
var collision_detector : bool = true

signal enemy_contacted(enemy: enemy_actor_class)

func _ready() -> void:
	connect_signals()

func connect_signals():
	pass
	
func _physics_process(delta: float) -> void:
# MOVEMENT
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = 3.50

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * stat_block.movement_speed
		velocity.z = direction.z * stat_block.movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, stat_block.movement_speed)
		velocity.z = move_toward(velocity.z, 0, stat_block.movement_speed)

	move_and_slide()

# COLLISION DETECTION
	if get_last_slide_collision() != null and collision_detector == true:
		
		#print_debug(player.get_last_slide_collision().get_collision_count())
		if get_last_slide_collision().get_collision_count() > 4:
			var collision_event : KinematicCollision3D = get_last_slide_collision()
			var curtailed_collision_count = (collision_event.get_collision_count() - 4)
			
			for collision_index in range(curtailed_collision_count):
				var collider = collision_event.get_collider(-collision_index)
				if collider is enemy_actor_class:
					enemy_contacted.emit(collider)
					collision_detector = false
				else:
					pass
	
