class_name player_inventory_component extends Node

var inventory : Array
signal inventory_button_pressed
# player_inventory_component is expected to handle child nodes
# not sure if that will last to final implementation, but
# it will be fine enough, I think.
# however, we can also keep a list of inventory here to help 
# understand the logic for the inventory. 

func add_item_to_inventory(item: StaticBody2D):
	item_base.new().player_pick_up_item(item, self)
	_refresh_inventory()

@warning_ignore("shadowed_global_identifier")
func remove_item_from_inventory(item: StaticBody2D, item_controller: Node):
	item.reparent(item_controller)
	_refresh_inventory()

func _refresh_inventory() -> void:
	inventory = get_children()
	
func get_inventory() -> Array:
	_refresh_inventory()
	print_debug(inventory)
	return inventory
	
@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		inventory_button_pressed.emit()

# TODO, maybe consider stacking items? Maybe inventory can handle that? IDK
