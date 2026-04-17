class_name overworld_enemy_class

var overworld_enemy: CharacterBody2D
var recorded_velocity: Vector2
var patrol_direction: Vector2 
var patrol_timer: int

var fighting_flag = false

var possible_random_directions =  [Vector2.LEFT, Vector2.UP, Vector2.DOWN, Vector2.RIGHT]

func _init(enemy_node: CharacterBody2D) -> void:
	overworld_enemy = enemy_node
	overworld_enemy.add_to_group('Enemy')

func patrol():
	if overworld_enemy.patrol == false and fighting_flag == false:
		patrol_timer = 0
		recorded_velocity = possible_random_directions.pick_random() * 40
		overworld_enemy.patrol = true
		
	if overworld_enemy.patrol == true:
		patrol_timer += 1
		#print_debug(overworld_enemy.patrol_time_limit)
		
		if patrol_timer >= overworld_enemy.patrol_time_limit: 
			overworld_enemy.patrol = false
			
	return recorded_velocity

func initiate_combat():
	overworld_enemy.patrol = false
	fighting_flag = true
