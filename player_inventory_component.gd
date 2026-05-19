class_name player_inventory_component extends Node

var inventory_house : inventory_resource = inventory_resource.new()

signal inventory_button_pressed
signal inventory_opened(inventory_house : inventory_resource)
signal inventory_closed

func add_item_to_inventory(item: item_class):
	inventory_house.inventory.append(item.scene_file_path)
	item.queue_free()

func remove_item_from_inventory(item: StaticBody2D, item_manager: item_controller):
	pass


@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		inventory_opened.emit(inventory_house)
	
	if Input.is_action_just_pressed("Exit_GUI"):
		print_debug(inventory_resource.new().inventory)

# TODO, maybe consider stacking items? Maybe inventory can handle that? IDK
