class_name map_region extends Node2D

@export var obstructions: TileMapLayer
@export var walkable_ground : TileMapLayer
@export var boundaries: TileMapLayer
@export var pathfinding_region : NavigationRegion2D

func _ready() -> void:
	add_to_group('Map')
	pathfinding_region.bake_navigation_polygon(true)
