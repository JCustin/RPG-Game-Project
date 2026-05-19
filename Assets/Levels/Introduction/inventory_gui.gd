extends Control
class_name inventory_gui
@export var inventory_list : ItemList

var item_being_dragged : item_class
var dragged_item_container : Dictionary


var inspected_item_index: int

var item_mod = item_modifier.new()

var mouse_inside_inventory: bool = false

var obstacle_tilemaplayer : TileMapLayer
@warning_ignore("shadowed_global_identifier")
var item_controller : Node

var engaged_in_combat_flag: bool

var player : player_character
var player_inventory : inventory_resource
var item_control_parent: item_controller



func cust_init(inventory_house : inventory_resource, item_control_parent_node: item_controller) -> void:
	add_to_group('Inventory')
	
	player_inventory = inventory_house
	item_control_parent = item_control_parent_node
	
	for item_container in inventory_house.inventory:
		_add_item_to_list(item_container)
	
func _on_inventory_list_mouse_entered() -> void:
	mouse_inside_inventory = true

func _on_inventory_list_mouse_exited() -> void:
	if mouse_inside_inventory == true:
		mouse_inside_inventory = false
	inventory_list.deselect_all()

# TODO - implement the inspect window better.
# see what stats we need for items and whatnot.
#func _on_inspect_pressed() -> void:
	#%Inspection_Panel.visible = true
	#var item = inventory_list.get_item_metadata(inspected_item_index)
	#var item_information = {
		#"name" : item.item_name,
		#"attack" : item.ATK,
		#"description" : item.item_description
	#}
	#
	#%Inspection_Description.text = "Strength: {attack} \n\n {description}".format(item_information)

func _on_throw_pressed() -> void:
	_start_dragging_item(inspected_item_index)

# TODO - refactor the close_inventory function signaled from game logic
# combat_start to just be the free_inventory func
@warning_ignore("unused_parameter")
func close_inventory(enemy_contacted: CharacterBody2D):
	# if item is being dragged, then return it to the list
	if item_being_dragged != null:
		@warning_ignore("redundant_await")
		await return_item_to_inventory()
		
	item_being_dragged = null
	visible = false
	free()

func free_inventory():
	if item_being_dragged != null:
		@warning_ignore("redundant_await")
		await return_item_to_inventory()
		
	item_being_dragged = null
	visible = false
	queue_free()
	
	
#func _add_item_to_list(item: item_class) -> void:
	#var new_item_index = inventory_list.add_item(item.item_name)
	#inventory_list.set_item_metadata(new_item_index, item.scene_file_path)
	
func _add_item_to_list(item_container: Dictionary) -> void:
	inventory_list.set_item_metadata(inventory_list.add_item(item_container["item_name"]), item_container)

func remove_item_from_list(item_index: int) -> void:
	var inventory_value = inventory_list.get_item_metadata(item_index)
	print_debug(inventory_value)
	inventory_list.remove_item(item_index)
	player_inventory.inventory.remove_at(item_index)
	
##code to handle clicking input for items on the list. 
func _on_inventory_list_item_clicked(_index: int, at_position: Vector2, mouse_button_index: int) -> void:
		if mouse_button_index == 1 and item_being_dragged == null: #left-click
			_start_dragging_item(inventory_list.get_item_at_position(at_position))
		
		if mouse_button_index == 2 and item_being_dragged == null: # right-click
			%Extended_Inventory_Panel.position = get_local_mouse_position()
			%Extended_Inventory_Panel.pivot_offset = Vector2(30, 10)
			
			%Extended_Inventory_Panel.visible = true
			inspected_item_index = inventory_list.get_item_at_position(at_position)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("Inventory_Click") and item_being_dragged != null:
		if mouse_inside_inventory == true:
			return_item_to_inventory()
		if mouse_inside_inventory == false:
			throw_item_in_world()
	
	if Input.is_key_pressed(KEY_SPACE):
		print_debug(player_inventory.inventory)

func _physics_process(_delta: float) -> void:
	if item_being_dragged != null:
		item_being_dragged.position = get_global_mouse_position()
		validate_throw_range()
	

func _start_dragging_item(item_index: int) -> void:
	%Extended_Inventory_Panel.visible = false
	print_debug(inventory_list.get_item_text(item_index))
	dragged_item_container = inventory_list.get_item_metadata(item_index)
	print_debug(dragged_item_container)
	
	item_being_dragged = load(dragged_item_container["file_path"]).instantiate()
	item_being_dragged.disable_collision()
	
	item_control_parent.add_child(item_being_dragged)
	remove_item_from_list(item_index)
	
func throw_item_in_world():
	if validate_placement_in_world() == true and validate_throw_range() == true:
		item_being_dragged.enable_collision()
		item_being_dragged.position = get_global_mouse_position()
		item_being_dragged = null
	else:
		return_item_to_inventory()

func return_item_to_inventory() -> void:
	player_inventory.inventory.append(dragged_item_container)
	print_debug(dragged_item_container)
	item_being_dragged.free()
	item_being_dragged = null
	await _add_item_to_list(dragged_item_container)
	dragged_item_container = {}
	
func validate_placement_in_world() -> bool:
	var item_placement = item_being_dragged.position
	var space_rid = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.set_position(item_placement)
	var result = space_rid.intersect_point(query)
	
	if result.size() == 0:
		return true
	else:
		return false

func validate_throw_range() -> bool:
	if item_being_dragged.position.distance_to(get_tree().get_first_node_in_group('Player').position) <= 160.00:	
			item_being_dragged.modulate = Color(1.0, 1.0, 1.0)
			return true
	
	else:
		item_being_dragged.modulate = Color.RED
		return false
		
