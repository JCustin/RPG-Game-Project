extends Control
@export var inventory_list : ItemList


func _ready() -> void:
	for player in get_tree().get_nodes_in_group('Player'):
		player.picked_up_item.connect(add_item_to_list)
	
func add_item_to_list(item: StaticBody2D) -> void:
	#inventory_list.add_item(item.item_name, null, true)
	inventory_list.set_item_tooltip(inventory_list.add_item(item.item_name, null, true), item.item_description)


func _on_inventory_list_item_selected(index: int) -> void:
	print_debug(index)
