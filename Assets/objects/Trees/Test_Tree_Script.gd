extends StaticBody2D
@export var shadow_sprite_pivot : Node2D
@export var shadow_sprite : Sprite2D

#func _physics_process(delta: float) -> void:
	#shadow_sprite.rotation_degrees += 1
	
func _physics_process(delta: float) -> void:
	shadow_sprite_pivot.rotation_degrees += 1
	
