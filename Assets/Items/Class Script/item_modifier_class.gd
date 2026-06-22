extends StaticBody2D
class_name item_modifier


func enable_collision(item: StaticBody2D):
	for child in item.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = false
			
func disable_collision(item: StaticBody2D):
	for child in item.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = true

func player_pick_up_item(item: item_class, inventory_container: inventory_resource):
	inventory_container.inventory.append(item.scene_file_path)
	pass
	
func player_throws_item(item: StaticBody2D, item_controller_parent: item_controller, thrown_position: Vector2):
	
	
	item.reparent(item_controller_parent)
	enable_collision(item)
	item.visible = true
	item.position = thrown_position
	
