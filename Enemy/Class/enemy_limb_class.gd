class_name enemy_limb_class extends Node2D

@export var stat_block : enemy_limb_stats_base

signal limb_lost(limb : enemy_limb_class)

func _ready() -> void:
	stat_block = stat_block.duplicate()
	stat_block.limb_lost.connect(kill_limb)


func switch_direction(direction: global_enums.combat_direction) -> void:
	var possible_combat_directions = global_enums.combat_direction
	var limb_direction = stat_block.limb_direction
	var texture : Sprite2D = get_child(0)
	match direction:
		
		possible_combat_directions.forward:
			
			match limb_direction:
				
				global_enums.limb_direction.forward_only:
					texture.texture = stat_block.front_texture
				
				global_enums.limb_direction.rear_only:
					texture.texture = null
					pass
					
				global_enums.limb_direction.both:
					texture.texture = stat_block.front_texture
		
		possible_combat_directions.rear:
			
			match limb_direction:
				
				global_enums.limb_direction.forward_only:
					texture.texture = null
					
				global_enums.limb_direction.rear_only:
					texture.texture = stat_block.rear_texture
					
				global_enums.limb_direction.both:
					texture.texture = stat_block.rear_texture
			
func kill_limb():
	limb_lost.emit(self)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color.RED, 1.0)
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 1.0)
	tween.tween_callback(func(): queue_free())
	
