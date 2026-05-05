class_name ai_movement_controller extends Node

@export var enemy : enemy_character
var behaviors : Array
var active_behavior : Node


func _ready() -> void:
	behaviors = get_children()
	active_behavior = behaviors[0]
	
func get_velocity() -> Vector2:
	return active_behavior.handle_movement()
	
func switch_behavior() -> void:
	var amount_of_behaviors = behaviors.size()
	if amount_of_behaviors > 1:
		active_behavior = behaviors[1]
	else:
		pass
