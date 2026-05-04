extends Node2D
var acting_enemy: Node2D
var player : player_character

func _ready() -> void:
	player = get_tree().get_first_node_in_group('Player')
	player.player_inventory_opened.connect(spawn_inventory_GUI)


#func _ready() -> void:
	#player.contacted_enemy.connect(initiate_combat)
	#player.open_inventory.connect(spawn_inventory_GUI)

func _physics_process(delta: float) -> void:
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
	#var combat_scene = preload("uid://buylh0rmqi1ll").instantiate()
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
#
func spawn_inventory_GUI(player: CharacterBody2D):
	if get_tree().get_nodes_in_group('Inventory').size() == 0:
		var inventory_GUI : inventory_gui = preload("uid://qhv78cbt13cn").instantiate()
		inventory_GUI.cust_init(player, %Item_Controller)
		%Camera.add_child(inventory_GUI)
		
		inventory_GUI.visible = true
	else:
		var inventory_GUI : inventory_gui = get_tree().get_first_node_in_group('Inventory')
		inventory_GUI.free()
