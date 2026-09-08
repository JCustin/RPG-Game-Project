class_name combat_manager_component extends Node

@export var actor_manager_component : actor_manager
@export var combat_scene : base_combat_scene
@export var map_manager : map_region_manager

signal combat_won
signal combat_lost

func _ready() -> void:
	actor_manager_component.combat_initiated.connect(start_combat)
	
func start_combat(
combat_players: Array[player_combat_actor_class], 
combat_enemies: Array[enemy_combat_actor_class]
):
	var combat_background_image : CompressedTexture2D
	combat_scene.initiate_combat(combat_players, combat_enemies, combat_background_image)
	
	
	
func win_combat():
	pass
	
func lose_combat():
	pass
