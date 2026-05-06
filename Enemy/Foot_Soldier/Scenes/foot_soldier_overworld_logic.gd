class_name foot_soldier_overworld extends enemy_character
@export var ai_movement_controller_component : ai_movement_controller

func _ready() -> void:
	combat_counterpart = preload("uid://bht10fb1cx40u").instantiate()

func _physics_process(delta: float) -> void:
	velocity = ai_movement_controller_component.get_velocity()
	move_and_slide()
