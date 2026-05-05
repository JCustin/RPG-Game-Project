extends Node2D
var acting_enemy: Node2D
var player : player_character

func _ready() -> void:
	player = get_tree().get_first_node_in_group('Player')
	_signal_connection()
	


func _signal_connection() -> void:
	player.player_inventory_opened.connect(spawn_inventory_GUI)
	Player_Data.combat_initiated.connect(initiate_combat)
#func _ready() -> void:
	#player.contacted_enemy.connect(initiate_combat)
	#player.open_inventory.connect(spawn_inventory_GUI)

func _physics_process(_delta: float) -> void:
	%Camera.position = player.position
	
	#
#func initiate_combat(enemy_node: Node2D):
	#player.initiate_combat()
	#acting_enemy = enemy_node
	#acting_enemy.add_to_group('Combat_Enemies')
	#
	#for node in get_tree().get_nodes_in_group('Inventory'):
		#node.free()
	#
	#acting_enemy.overworld_behavior.initiate_combat(acting_enemy)
	#
	var combat_scene = preload("uid://buylh0rmqi1ll").instantiate()
	#combat_scene.custom_initialize(acting_enemy)
	#add_child(combat_scene)
	#combat_scene.combat_complete.connect(end_combat)
	#
	#%Overworld.visible = false
	#%Camera.enabled = false	
#
#func end_combat(victory: bool):
	#%Overworld.visible = true
	#%Camera.enabled = true
	#player.end_combat()
	#
	#if victory == true:
		#acting_enemy.free() 
	#else:
		#await get_tree().create_timer(1.0).timeout
		#acting_enemy.overworld_behavior.end_fled_combat(acting_enemy)

func initiate_combat(player_initiating_combat: player_character, enemy_initiating_combat: CharacterBody2D):
	print_debug('Does this shih work')
	var combat_scene : combat_scene_class = preload("uid://buylh0rmqi1ll").instantiate()
	add_child(combat_scene)
	combat_scene.cust_init(player_initiating_combat, enemy_initiating_combat)
	# the above code may need to change when implementing multiple player_characters. 
	
	# the code below is blocked out. Maybe combat_scene can help set up parameters
	# for how the combat ends, then just validate this through a single signal. 
	
	#combat_scene.combat_won.connect(end_combat_win)
	#combat_scene.combat_fled.connect(end_combat_fled)
	#combat_scene.combat_fled.connect(player_defeated)
	
	for inventory_node : inventory_gui in get_tree().get_nodes_in_group('Inventory'):
		inventory_node.free_inventory()
	
	%Overworld.visible = false
	for item in %Item_Controller.get_children():
		item.visible = false
	

func spawn_inventory_GUI(player_requesting_inventory: CharacterBody2D):
	if get_tree().get_nodes_in_group('Inventory').size() == 0:
		var inventory_GUI : inventory_gui = preload("uid://qhv78cbt13cn").instantiate()
		inventory_GUI.cust_init(player_requesting_inventory, %Item_Controller)
		%Camera.add_child(inventory_GUI)
		
		inventory_GUI.visible = true
	else:
		var inventory_GUI : inventory_gui = get_tree().get_first_node_in_group('Inventory')
		inventory_GUI.free()
