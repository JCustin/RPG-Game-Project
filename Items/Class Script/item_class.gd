class_name item_class extends StaticBody2D

@export var item_name : String
@export var item_description: String
@export var item_type : global_enums.item_types
@export var texture : Sprite2D
@export var collision_box : CollisionShape2D

func disable_collision() -> void:
	collision_box.disabled = true
	
func enable_collision() -> void:
	collision_box.disabled = false
