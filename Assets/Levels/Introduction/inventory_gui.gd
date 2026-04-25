extends Control
@export var inventory_list : ItemList

var internal_item_scene_packaging: Dictionary
var item_dragged: bool = false

var item_being_dragged: StaticBody2D 
var item_being_inspected: StaticBody2D

var mouse_inside_inventory: bool = false

func _ready() -> void:
	for player in get_tree().get_nodes_in_group('Player'):
		player.picked_up_item.connect(add_item_to_list)
		player.open_inventory.connect(open_inventory)

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
		

		
		#print_debug(item_name)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and item_dragged == true:
		item_being_dragged.visible = true
		item_being_dragged.position = get_global_mouse_position()
		print_debug(item_being_dragged.position)
		
	if Input.is_action_just_released("Inventory_Click") and item_dragged == true:
		if mouse_inside_inventory == true:
			await add_item_to_list(item_being_dragged)
			item_being_dragged.visible = false
			item_being_dragged.position = Vector2(1000,1000)
			item_dragged = false
			
		else:
			item_being_dragged.position = get_global_mouse_position()
			item_being_dragged.collision_layer = 2
			item_being_dragged.reparent(%Item_Controller)
			item_dragged = false
			
	if Input.is_key_pressed(KEY_ESCAPE) and visible == true:
		close_inventory()


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


func _on_inventory_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
		if mouse_button_index == 2:
			%Extended_Inventory_Panel.position = get_local_mouse_position()
			%Extended_Inventory_Panel.pivot_offset = Vector2(30, 10)
			
			%Extended_Inventory_Panel.visible = true
			var item_index = inventory_list.get_item_at_position(get_local_mouse_position())
			var item_name = inventory_list.get_item_text(item_index)
			
			item_being_inspected = internal_item_scene_packaging[item_name]
			print_debug("we are inspecting the following item ", item_being_inspected)


func _on_inspect_pressed() -> void:
	%Inspection_Panel.visible = true
	var string_sub_data : Dictionary
	string_sub_data["ATK"] = item_being_inspected.ATK
	string_sub_data["item_description"] = item_being_inspected.item_description
	%Inspection_Description.text = "Strength: {ATK}. \n \n {item_description}".format(string_sub_data)
	
	
	#%Inspection_Description.text = "Strength: ", String(item_being_inspected.ATK_addition), "
	#
	#", String(item_being_inspected.item_descrption)
	
	#%Inspection_Description.text = item_being_inspected.item_description
	
	pass # Replace with function body.
