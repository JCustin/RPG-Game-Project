class_name enemy_actor_class extends base_actor_class

func _ready() -> void:
	set_collision_layer_value(2, true) 
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, true)
	
