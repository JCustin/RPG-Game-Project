class_name ai_movement_controller extends Node

@export var enemy : enemy_character
@export var movement_behaviors : Array[movement_behavior_resource_base]

var behaviors : Array
var active_behavior : Node

var active : bool = true

func _physics_process(delta: float) -> void:
	var direction = _find_direction()
	enemy.velocity = direction * 100
	enemy.move_and_slide()

func _ready() -> void:
	behaviors = get_children()
	
func _find_direction() -> Vector2:
	var possible_directions: Array = [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.UP]
	var chosen_direction = possible_directions.pick_random()
	return chosen_direction
	
	
	
