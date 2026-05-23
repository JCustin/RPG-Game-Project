class_name ai_movement_controller extends Node

@export var enemy : enemy_character
@export var movement_behaviors : Array[movement_behavior_resource_base]

var behaviors : Array
var active_behavior : Node

var pathfinder : AStar2D = AStar2D.new()

var active : bool = true

func _physics_process(delta: float) -> void:
	if active == true:
		var direction = _find_direction()
		enemy.velocity = direction * 100
		enemy.move_and_slide()

func _ready() -> void:
	behaviors = get_children()
	
	
func find_patrol_point() -> void:
	var map = get_tree().get_first_node_in_group('Map')
	var walkable_map_layer : TileMapLayer = map.get_child(1)
	var walkable_tiles = walkable_map_layer.get_used_cells()
	
	var patrol_point = walkable_tiles.pick_random()
	
	
	


func _find_direction() -> Vector2:
	var possible_directions: Array = [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.UP]
	var chosen_direction = possible_directions.pick_random()
	return chosen_direction
	
	
	
