class_name tree_pop extends StaticBody2D
@export var shadow_sprite_pivot : Node2D
@export var shadow_sprite : Sprite2D

enum day_night_states {DAY, EVENING, NIGHT}
	
	
func adjust_shadow_lighting(day_state: int) -> void:
	match day_state:
		
		day_night_states.DAY:
			shadow_sprite_pivot.visible = false
			shadow_sprite_pivot.rotation_degrees = 45
			
		day_night_states.EVENING:
			shadow_sprite_pivot.visible = false
			shadow_sprite_pivot.rotation_degrees = 180
			
		day_night_states.NIGHT:
			shadow_sprite_pivot.visible = false
	
