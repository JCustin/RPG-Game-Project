extends player_character 
@export var movement_controller: player_movement_controller
@export var interaction_component: player_interaction_component
@export var inventory_component : player_inventory_component
@export var collision_box : CollisionShape2D
@export var movement_speed: int 

var stat_block : witch_hunter_stats

signal player_inventory_opened(player: CharacterBody2D)
var in_combat : bool = false

func _ready() -> void:
	#add_to_group('Player')
	connect_signals()
	combat_counterpart = preload("uid://cwj3drr7ohmnm").instantiate()
		
	stat_block = witch_hunter_stats.new().duplicate()
	print(stat_block.HP)

func connect_signals():
	movement_controller.movement_direction.connect(calculate_velocity)
	interaction_component.player_picked_up_item.connect(move_item_to_inventory)
	inventory_component.inventory_button_pressed.connect(func(): player_inventory_opened.emit(self))
	Player_Data.combat_initiated.connect(initiate_combat)

func _physics_process(_delta: float) -> void:
	
	
	if in_combat == false:
		move_and_slide()
		print_debug(position)

func calculate_velocity(direction: Vector2):
	velocity = direction * movement_speed

func move_item_to_inventory(item: StaticBody2D):
	inventory_component.add_item_to_inventory(item)

func initiate_combat(_player_initiating_combat, _enemy_initiating_combat) -> void:
	in_combat = true
	collision_box.disabled = true
	
func end_combat():
	var components = [inventory_component, interaction_component, movement_controller]
	for node in components:
		node.set_process(Node.PROCESS_MODE_INHERIT)
	collision_box.enabled = true
	
	
