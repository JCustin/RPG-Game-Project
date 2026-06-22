class_name enemy_character extends CharacterBody2D

var combat_counterpart : combat_enemy_character
var unit_name : String
var unit_description : String

@export var ai_movement_controller : ai_movement_controller
@export var collision_box : CollisionShape2D

func _init() -> void:
	set_collision_layer_value(3, true)
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, true)
	set_collision_mask_value(4, true)
	await ready
	combat_counterpart.enemy_wounded.connect(_flee)
	z_index = 10

func stun_after_combat():
	collision_box.disabled = true
	#AI_movement_controller.active = false
	
	await get_tree().create_timer(1.0).timeout
	
	collision_box.disabled = false
	#AI_movement_controller.active = true

func _flee():
	pass

func _physics_process(_delta: float) -> void:
	var direction = ai_movement_controller.find_direction()
	velocity = direction * 100
	move_and_slide()
