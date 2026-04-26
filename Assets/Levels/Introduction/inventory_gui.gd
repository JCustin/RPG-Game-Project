extends Control
@export var inventory_list : ItemList

var internal_item_scene_packaging: Dictionary
var item_dragged: bool = false

var item_being_dragged: StaticBody2D 
var item_being_inspected: StaticBody2D

var mouse_inside_inventory: bool = false

var obstacle_tilemaplayer : TileMapLayer

func _ready() -> void:
	for player in get_tree().get_nodes_in_group('Player'):
		player.picked_up_item.connect(add_item_to_list)
		player.open_inventory.connect(open_inventory)
		player.contacted_enemy.connect(close_inventory_for_combat)
		
	obstacle_tilemaplayer = get_tree().get_first_node_in_group('Obstacles')

func _physics_process(delta: float) -> void:
	if item_dragged == true:
		item_being_dragged.position = get_global_mouse_position()
		validate_throw_range()

func add_item_to_list(item: StaticBody2D) -> void:
	#inventory_list.add_item(item.item_name, null, true)
	inventory_list.set_item_tooltip(inventory_list.add_item(item.item_name, null, true), item.item_description)
	internal_item_scene_packaging[item.item_name] = item
		#print_debug(internal_item_scene_packaging)


func _on_inventory_list_item_selected(index: int) -> void:
	if Input.is_action_just_pressed("Inventory_Click") and item_dragged == false:
		item_dragged = true
		var item_name = inventory_list.get_item_text(index)
		item_being_dragged = internal_item_scene_packaging[item_name]
		inventory_list.remove_item(index)
		
#
		#
		##print_debug(item_name)
	
func _input(event: InputEvent) -> void:
	if Input.is_anything_pressed() and item_dragged == true:
		if item_being_dragged == null:
			return
		else:
			item_being_dragged.visible = true
			validate_throw_range()
			#item_being_dragged.position = get_global_mouse_position()

	
	if Input.is_action_just_released("Inventory_Click") and item_dragged == true:
		if mouse_inside_inventory == true:
			return_dragged_item_to_inventory()
		else:
			throw_item_in_world()
			
			
	if Input.is_key_pressed(KEY_ESCAPE) and visible == true:
		if %Inspection_Panel.visible == true:
			%Inspection_Panel.visible = false
			return
		if %Extended_Inventory_Panel.visible == true:
			%Extended_Inventory_Panel.visible = false
			return
		if visible == true:
			visible = false
			
		


func _on_inventory_list_mouse_entered() -> void:
	mouse_inside_inventory = true

func _on_inventory_list_mouse_exited() -> void:
	if mouse_inside_inventory == true:
		mouse_inside_inventory = false
	inventory_list.deselect_all()

func open_inventory():
	visible = true
	
func close_inventory():
	visible = false
	inventory_list.deselect_all()

func begin_dragging_item(item: StaticBody2D) -> void:
	item_dragged = true
	item_being_dragged = item
	item_being_dragged.visible = true
	var index = inventory_list.get_item_at_position(get_global_mouse_position())
	inventory_list.remove_item(index)
	%Inspection_Panel.visible = false
	%Extended_Inventory_Panel.visible = false
	

func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
		if mouse_button_index == 2:
			%Extended_Inventory_Panel.position = get_local_mouse_position()
			%Extended_Inventory_Panel.pivot_offset = Vector2(30, 10)
			
			%Extended_Inventory_Panel.visible = true
			var item_index = inventory_list.get_item_at_position(get_local_mouse_position())
			var item_name = inventory_list.get_item_text(item_index)
			
			item_being_inspected = internal_item_scene_packaging[item_name]


func _on_inspect_pressed() -> void:
	%Inspection_Panel.visible = true
	var string_sub_data : Dictionary
	string_sub_data["ATK"] = item_being_inspected.ATK
	string_sub_data["item_description"] = item_being_inspected.item_description
	%Inspection_Description.text = "Strength: {ATK}. \n \n {item_description}".format(string_sub_data)

	
func _on_throw_pressed() -> void:
	begin_dragging_item(item_being_inspected)
	
func close_inventory_for_combat(contacted_enemy: CharacterBody2D):
	# if item is being dragged, then return it to the list
	if item_being_inspected != null:
		return_dragged_item_to_inventory()
		
	item_dragged = false
	item_being_dragged = null
	item_being_inspected = null
	visible = false
	
func return_dragged_item_to_inventory() -> void:
	await add_item_to_list(item_being_dragged)
	item_being_dragged.visible = false
	item_being_dragged.position = Vector2(1000,1000)
	item_dragged = false
	
func throw_item_in_world() -> void:
	if validate_throw_range() == true and validate_placement_in_world() == true:
		item_being_dragged.position = get_global_mouse_position()
		item_being_dragged.collision_layer = 2
		item_being_dragged.reparent(%Item_Controller)
		item_dragged = false
		
	else:
		return_dragged_item_to_inventory()
	
	
func validate_throw_range() -> bool:
	if item_being_dragged.position.distance_to(get_tree().get_first_node_in_group('Player').position) <= 160.00:	
			item_being_dragged.modulate = Color(1.0, 1.0, 1.0)
			return true
	
	else:
		item_being_dragged.modulate = Color.RED
		return false
		
func validate_placement_in_world() -> bool:
	var item_placement = item_being_dragged.position
	var space_rid = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.set_position(item_placement)
	#var point_position = query.set_position(item_placement)
	
	#var query = PhysicsRayQueryParameters2D.create(item_placement, item_placement, 4)
	var result = space_rid.intersect_point(query)
	print_debug(result)
	
	if result.size() == 0:
		return false
		
	else:
		var first_collision_result = result[0]
		var colliding_object = first_collision_result["collider"]
		if colliding_object != item_being_dragged: # if the colliding object is NOT the item itself
			print_debug(colliding_object)
			return false
		
		else:
			return true
