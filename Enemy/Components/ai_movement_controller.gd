class_name ai_movement_controller extends Node

@export var enemy : enemy_character
@export var movement_behaviors : Array[movement_behavior_resource_base]

var behaviors : Array
var active_behavior : Node

#func _physics_process(delta: float) -> void:
	#enemy.velocity = get_velocity()
	#enemy.move_and_slide()

func _ready() -> void:
	behaviors = get_children()
	
#func get_velocity() -> Vector2:
	#return active_behavior.handle_movement()
	#
func switch_behavior() -> void:
	var amount_of_behaviors = behaviors.size()
	if amount_of_behaviors > 1:
		active_behavior = behaviors[1]
	else:
		pass
