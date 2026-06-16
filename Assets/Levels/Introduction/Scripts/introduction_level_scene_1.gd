class_name map_region extends Node2D

@export var obstructions: TileMapLayer
@export var walkable_ground : TileMapLayer
@export var boundaries: TileMapLayer

var pathfinder : AStarGrid2D = AStarGrid2D.new()

func _ready() -> void:
	add_to_group('Map')
	_prepare_pathfinder()

func _prepare_pathfinder() -> void:
	pathfinder.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinder.region = walkable_ground.get_used_rect()
	pathfinder.cell_size = Vector2(64,64)
	pathfinder.update()

	for object in obstructions.get_children():
		var object_position : Vector2 = obstructions.local_to_map(object.position.round())
		pathfinder.set_point_solid(object_position)
