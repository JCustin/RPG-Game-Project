extends player_character 

@export var movement_controller: player_movement_controller
@export var interaction_component: player_interaction_component
@export var inventory_component : player_inventory_component
@export var combat_init_component : combat_initation_component
@export var collision_box : CollisionShape2D
@export var movement_speed: int 


signal player_inventory_opened(player: CharacterBody2D)
var in_combat : bool = false

func _ready() -> void:
	#add_to_group('Player')
	connect_signals()
	combat_counterpart = preload("uid://cwj3drr7ohmnm").instantiate()
	#print(player_stat_block_resource.HP)

func connect_signals():
	interaction_component.player_picked_up_item.connect(move_item_to_inventory)
	inventory_component.inventory_button_pressed.connect(func(): player_inventory_opened.emit(self))

func move_item_to_inventory(item: StaticBody2D):
	inventory_component.add_item_to_inventory(item)
