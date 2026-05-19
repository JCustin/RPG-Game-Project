extends player_character 

@export var movement_component : player_movement_controller
@export var interaction_component: player_interaction_component
@export var inventory_component : player_inventory_component

signal player_inventory_opened(inventory)
var in_combat : bool = false

func _ready() -> void:
	add_to_group('Player')
	connect_signals()
	combat_counterpart = preload("uid://cwj3drr7ohmnm").instantiate()

func connect_signals():
	interaction_component.player_picked_up_item.connect(move_item_to_inventory)
	inventory_component.inventory_opened.connect(
		func(inventory: inventory_resource): 
		player_inventory_opened.emit(inventory)
		interaction_component.active = false
		
		)
		
	inventory_component.inventory_closed.connect(
		func():
		interaction_component.active = true
	)

func move_item_to_inventory(item: StaticBody2D):
	inventory_component.add_item_to_inventory(item)
