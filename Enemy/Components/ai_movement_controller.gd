class_name ai_movement_controller extends Node

@export var enemy : enemy_character
var active_behavior: Node

func _ready() -> void:
	active_behavior = get_child(0)
	
func get_velocity() -> Vector2:
	return active_behavior.handle_movement()
