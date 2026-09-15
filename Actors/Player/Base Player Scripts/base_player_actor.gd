class_name base_player_actor extends base_actor_class
@export var texture : base_actor_texture_component

signal contacted_enemy(enemy: base_enemy_actor)

var local_enemies : Array[base_enemy_actor]

func _ready() -> void:
	%Combat_Initiation_Range.body_entered.connect(validate_combat_initiation)
	%"Local Enemy Detector".body_entered.connect(add_to_local_enemies)
	%"Local Enemy Detector".body_exited.connect(remove_from_local_enemies)

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
	
# checks if body entered is an enemy_actor, and if so, combat shall start
func validate_combat_initiation(body):
	if body is base_enemy_actor:
		contacted_enemy.emit(body)
		
func add_to_local_enemies(body) -> void:
	if body is base_enemy_actor:
		local_enemies.append(body)
	
func remove_from_local_enemies(body) -> void:
	if body is base_enemy_actor:
		local_enemies.erase(body)
