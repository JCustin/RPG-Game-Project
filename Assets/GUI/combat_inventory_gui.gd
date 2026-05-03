extends Control
@export var inventory_list : ItemList
var inspected_item_index: int

var item_modifier = item_base.new()

var mouse_inside_inventory: bool = false

var engaged_in_combat_flag: bool

func _ready() -> void:
	add_to_group('Inventory')
	print_debug(Player_Data.inventory)
	for item in Player_Data.inventory:
		_add_item_to_list(item)
	
	for player in get_tree().get_nodes_in_group('Player'):
		player.picked_up_item.connect(_add_item_to_list)

func _on_inventory_list_mouse_entered() -> void:
	mouse_inside_inventory = true

func _on_inventory_list_mouse_exited() -> void:
	if mouse_inside_inventory == true:
		mouse_inside_inventory = false
	inventory_list.deselect_all()

# TODO - implement the inspect window better.
# see what stats we need for items and whatnot.
func _on_inspect_pressed() -> void:
	%Inspection_Panel.visible = true
	var item = inventory_list.get_item_metadata(inspected_item_index)
	var item_information = {
		"name" : item.item_name,
		"attack" : item.ATK,
		"description" : item.item_description
	}
	
	%Inspection_Description.text = "Strength: {attack} \n\n {description}".format(item_information)

func _add_item_to_list(item: StaticBody2D) -> void:
	var new_item_index = inventory_list.add_item(item.item_name)
	inventory_list.set_item_metadata(new_item_index, item)
	

func remove_item_from_list(item_index: int) -> void:
	var inventory_value = inventory_list.get_item_metadata(item_index)
	inventory_list.remove_item(item_index)
	
	Player_Data.inventory.erase(inventory_value)
	print_debug(Player_Data.inventory)
	
##code to handle clicking input for items on the list. 
func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == 2: # right-click
		%Extended_Inventory_Panel.position = get_local_mouse_position()
		%Extended_Inventory_Panel.pivot_offset = Vector2(30, 10)
		%Extended_Inventory_Panel.visible = true
		inspected_item_index = inventory_list.get_item_at_position(at_position)
