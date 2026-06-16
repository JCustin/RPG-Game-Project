class_name map_region extends Node2D

@export var obstructions: TileMapLayer
@export var walkable_ground : TileMapLayer
@export var boundaries: TileMapLayer

var pathfinder : AStarGrid2D = AStarGrid2D.new()

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	print_debug(walkable_ground.local_to_map(mouse_pos))

func _ready() -> void:
	add_to_group('Map')
	_prepare_pathfinder()

func _prepare_pathfinder() -> void:
	#sawdsawdsa
	pathfinder.region = walkable_ground.get_used_rect()
	pathfinder.cell_size = Vector2(128,128)
	pathfinder.update()

	for obstruction in obstructions.get_children():
		var points_to_solidify : Array = []
		
		var obstruction_position = walkable_ground.local_to_map(obstruction.position)
		points_to_solidify.append(obstruction_position)
		#pathfinder.set_point_solid(obstruction_position, true)
		
		var surrounding_cells = walkable_ground.get_surrounding_cells(obstruction_position)
		points_to_solidify.append_array(surrounding_cells)
		#print_debug(surrounding_cells, obstruction_position)
		
		#for cell in surrounding_cells:
			#var neighbor = walkable_ground.get_surrounding_cells(cell)
			#points_to_solidify.append_array(neighbor)
			
		for point in points_to_solidify:
			pathfinder.set_point_solid(point)
