class_name map_region extends Node2D

signal player_transitioning_regions(direction: Vector2)

@export var obstructions: TileMapLayer
@export var walkable_ground : TileMapLayer
@export var boundaries: TileMapLayer
@export var pathfinding_region : NavigationRegion2D

@export var south_transition : map_transition_stage_area
@export var north_transition : map_transition_stage_area
@export var east_transition : map_transition_stage_area
@export var west_transition : map_transition_stage_area

func _ready() -> void:
	add_to_group('Map')
	pathfinding_region.bake_navigation_polygon(true)
	var transition_stages : Array = [north_transition, south_transition, east_transition, west_transition]
	for stage : map_transition_stage_area in transition_stages:
		if stage != null:
			stage.player_entered_transition_stage_area.connect(_find_player_transition_direction)

func _find_player_transition_direction(transition_stage : map_transition_stage_area):
	match transition_stage:
		north_transition:
			player_transitioning_regions.emit(Vector2(0,1))
		
		south_transition:
			player_transitioning_regions.emit(Vector2(0,-1))
			
		east_transition:
			player_transitioning_regions.emit(Vector2(1,0))
			
		west_transition:
			player_transitioning_regions.emit(Vector2(-1,0))
