class_name base_combat_scene extends Node3D

@export var background_image : CompressedTexture2D
var combat_players : Array[player_combat_actor_class]
var combat_enemies : Array[enemy_combat_actor_class]
@export var camera : Camera3D

var location_manager : combat_location_manager

func initiate_combat(
loaded_combat_players : Array[player_combat_actor_class], 
loaded_combat_enemeies : Array[enemy_combat_actor_class], 
background_scene : CompressedTexture2D
):
	combat_players = loaded_combat_players
	combat_enemies = loaded_combat_enemeies
