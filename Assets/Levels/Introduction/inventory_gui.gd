extends Control
class_name inventory_gui
@export var inventory_list : ItemList

var item_being_dragged: StaticBody2D 
var inspected_item_index: int

var item_modifier = item_base.new()

var mouse_inside_inventory: bool = false

var obstacle_tilemaplayer : TileMapLayer
var item_controller : Node

var engaged_in_combat_flag: bool

# TODO
# maybe implement a weight system? 
# one way to hit that shih is to just enter that value in the item 
# then maintain a global array that adds the sum of the items
# which is then updated when items are added or removed

func _ready() -> void:
	item_controller = get_tree().get_first_node_in_group('Item_Controller')
	add_to_group('Inventory')
	for item in Player_Data.inventory:
		_add_item_to_list(item)
	
	for player in get_tree().get_nodes_in_group('Player'):
		player.picked_up_item.connect(_add_item_to_list)
		player.open_inventory.connect(open_inventory)
		player.contacted_enemy.connect(close_inventory)
		
	obstacle_tilemaplayer = get_tree().get_first_node_in_group('Obstacles')
	
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

func _on_throw_pressed() -> void:
	_start_dragging_item(inspected_item_index)
	
func open_inventory():
	visible = true
	
func close_inventory(enemy_contacted: CharacterBody2D):
	# if item is being dragged, then return it to the list
	if item_being_dragged != null:
		await return_item_to_inventory()
		
	item_being_dragged = null
	visible = false

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
		if mouse_button_index == 1 and item_being_dragged == null: #left-click
			_start_dragging_item(inventory_list.get_item_at_position(at_position))
		
		if mouse_button_index == 2 and item_being_dragged == null: # right-click
			%Extended_Inventory_Panel.position = get_local_mouse_position()
			%Extended_Inventory_Panel.pivot_offset = Vector2(30, 10)
			
			%Extended_Inventory_Panel.visible = true
			inspected_item_index = inventory_list.get_item_at_position(at_position)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Inventory_Click") and item_being_dragged != null:
		if mouse_inside_inventory == true:
			return_item_to_inventory()
		if mouse_inside_inventory == false:
			throw_item_in_world()
			
	if Input.is_action_just_pressed("Exit_GUI") or Input.is_action_just_pressed("Inventory"):
		if item_being_dragged != null:
			return_item_to_inventory()
		free()

func _physics_process(delta: float) -> void:
	if item_being_dragged != null:
		item_being_dragged.position = get_global_mouse_position()
		validate_throw_range()

func _start_dragging_item(item_index: int) -> void:
	%Extended_Inventory_Panel.visible = false
	item_being_dragged = inventory_list.get_item_metadata(item_index)
	item_modifier.disable_collision(item_being_dragged)
	item_being_dragged.visible = true
	remove_item_from_list(item_index)	
	
func throw_item_in_world():
	if validate_placement_in_world() == true and validate_throw_range() == true:
		item_modifier.enable_collision(item_being_dragged)
		item_being_dragged.position = get_global_mouse_position()
		item_being_dragged.reparent(item_controller)
		
		item_being_dragged = null
	else:
		return_item_to_inventory()

func return_item_to_inventory() -> void:
	_add_item_to_list(item_being_dragged)
	Player_Data.inventory += [item_being_dragged]
	item_being_dragged.visible = false
	item_being_dragged = null
	
func validate_placement_in_world() -> bool:
	var item_placement = item_being_dragged.position
	var space_rid = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.set_position(item_placement)
	var result = space_rid.intersect_point(query)
	print_debug(result)
	
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
		
