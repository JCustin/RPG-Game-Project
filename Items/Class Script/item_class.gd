extends StaticBody2D
class_name item_base

#var parent: StaticBody2D
#
#func _init(parent_node: StaticBody2D) -> void:
	#parent = parent_node

func enable_collision(item: StaticBody2D):
	for child in item.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = false
			
func disable_collision(item: StaticBody2D):
	for child in item.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = true
