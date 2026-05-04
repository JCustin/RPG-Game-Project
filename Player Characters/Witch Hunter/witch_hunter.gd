extends CharacterBody2D
@export var movement_controller: player_movement_controller
@export var movement_speed: int 

func _ready() -> void:
	movement_controller.movement_direction.connect(calculate_velocity)

func _physics_process(delta: float) -> void:
	move_and_slide()

func calculate_velocity(direction: Vector2):
	velocity = direction * movement_speed
