extends CharacterBody2D
var target_patrol_position = Vector2i.ZERO
var map_stack
var ground_map: TileMapLayer
var fighting: bool = false

@export var unit_id: String = "Wall_Rat"
@export var patrol_timer_ms: int = 100

#var combat_unit_counterpart = preload("res://Enemy/Wall Rat/Wall_Rat_Combat.tscn")
var combat_unit_counterpart = preload("uid://dr5bfgnwws2pj") # TESTING
var unit_name = "Wall Rat"

var patrolling: bool = false
var time_spent_patrolling: int = 0 
var patrol_direction: Vector2

var last_known_position: Vector2

func _ready() -> void:
	add_to_group('Enemy')
	ground_map = get_tree().get_first_node_in_group('Map').get_child(0)

	
func _physics_process(delta: float) -> void:
	if fighting == false:
		patrol()

		
func initiate_combat():
	fighting = true
	
func patrol():	
	if patrolling == false:
		var possible_random_directions =  [Vector2.LEFT, Vector2.UP, Vector2.DOWN, Vector2.RIGHT]
		patrol_direction = possible_random_directions.pick_random()
		patrolling = true
		
	else:
		if time_spent_patrolling <= patrol_timer_ms:
			velocity = patrol_direction * 30
			move_and_slide()
			time_spent_patrolling += 1
			
		if time_spent_patrolling >= patrol_timer_ms:
			
			time_spent_patrolling = 0
			patrolling = false
		
func end_combat():
	%Rat_Wall_Collision.disabled = true
	await get_tree().create_timer(1.5).timeout
	%Rat_Wall_Collision.disabled = false
	fighting = false


#func end_combat():
	#fighting = false
	#position = Vector2(last_known_position.x + 20, last_known_position.y)
	#print(position)
	#scale.x = 0
	#scale.y = 0
