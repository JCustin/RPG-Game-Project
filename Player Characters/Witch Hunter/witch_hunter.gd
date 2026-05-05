extends player_character 
@export var movement_controller: player_movement_controller
@export var interaction_component: player_interaction_component
@export var inventory_component : player_inventory_component
@export var movement_speed: int 

var stat_block : witch_hunter_stats

signal player_inventory_opened(player: CharacterBody2D)

func _ready() -> void:
	#add_to_group('Player')
	connect_signals()
	
	stat_block = witch_hunter_stats.new().duplicate()
	print(stat_block.HP)

func connect_signals():
	movement_controller.movement_direction.connect(calculate_velocity)
	interaction_component.player_picked_up_item.connect(move_item_to_inventory)
	inventory_component.inventory_button_pressed.connect(func(): player_inventory_opened.emit(self))

func _physics_process(_delta: float) -> void:
	move_and_slide()

func calculate_velocity(direction: Vector2):
	velocity = direction * movement_speed

func move_item_to_inventory(item: StaticBody2D):
	inventory_component.add_item_to_inventory(item)
	
