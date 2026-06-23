class_name Game extends Node

@export var combat_manager : combat_manager_component
@export var map_manager : map_region_manager
@export var actor_manager : actor_controller
@export var item_manager : item_controller
@export var camera : game_camera

var acting_enemy: Node2D
var player : player_character

func _ready() -> void:
	actor_manager.add_actor(actor_manager.get_child(0))
	camera.reparent(actor_manager.player_list[0])

	
	
	
	_signal_connection()

func _signal_connection() -> void:
	#player.player_inventory_opened.connect(spawn_inventory_GUI)
	Player_Data.combat_initiated.connect(_start_combat)
	Player_Data.combat_ended.connect(_end_combat)
	

func _start_combat(player_initiating_combat: player_character, enemy_initiating_combat: enemy_character) -> void:
	camera.enabled = false
	combat_manager.initiate_combat(player_initiating_combat, enemy_initiating_combat)
	
func _end_combat():
	camera.enabled = true


#func spawn_inventory_GUI(player_inventory: inventory_resource):
	#if get_tree().get_nodes_in_group('Inventory').size() == 0:
		#var inventory_GUI : inventory_gui = preload("uid://qhv78cbt13cn").instantiate()
		#inventory_GUI.cust_init(player_inventory, %Item_Controller)
		#add_child(inventory_GUI)
		#
		#inventory_GUI.visible = true
	#else:
		#var inventory_GUI : inventory_gui = get_tree().get_first_node_in_group('Inventory')
		#inventory_GUI.free()
