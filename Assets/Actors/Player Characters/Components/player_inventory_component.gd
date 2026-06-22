class_name player_inventory_component extends Node

var inventory_house : inventory_resource = inventory_resource.new()

signal inventory_button_pressed
signal inventory_opened(inventory_house : inventory_resource)
signal inventory_closed

signal added_item_to_inventory(item_container: Dictionary) # to connect to the inventory system in real time

var inventory_open : bool = false

func add_item_to_inventory(item: item_class):
	var item_id = randf_range(0, 100000.00)
	
	if inventory_house.inventory.size() > 0:
		for inventory_item in inventory_house.inventory:
			var recorded_item_id = inventory_item["ID"]
			if item_id == recorded_item_id:
				item_id += 0.01
	
	var item_container : Dictionary = {
		"ID": item_id, 
		"file_path": item.scene_file_path,
		"item_name": item.item_name,
		"item_description": item.item_description
	}
	
	inventory_house.inventory.append(item_container)
	item.queue_free()


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory") and inventory_open == false:
		inventory_opened.emit(inventory_house)
		inventory_open = true
		
	if Input.is_action_just_pressed("Inventory") and inventory_open == true:
		inventory_closed.emit()
		inventory_open = false

# TODO, maybe consider stacking items? Maybe inventory can handle that? IDK
