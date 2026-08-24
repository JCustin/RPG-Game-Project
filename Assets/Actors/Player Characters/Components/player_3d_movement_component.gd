class_name player_3d_movement_controller extends Node
@export var player : player_actor_class
var active_flag : bool = true
var movement_speed : int

func _ready() -> void:
	movement_speed = player.stat_block.movement_speed

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = 3.50

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * movement_speed
		player.velocity.z = direction.z * movement_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, movement_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, movement_speed)

	player.move_and_slide()
