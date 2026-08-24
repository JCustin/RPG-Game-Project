class_name player_controller_manager extends Node

signal initiate_combat(enemy_actor: enemy_actor_class)

@export var player : player_actor_class
@export var map_manager : map_region_manager
@export var combat_manager : combat_manager_component

func _connect_signal_from_children():
	player.enemy_contacted.connect(
			func(enemy: enemy_actor_class): 
			initiate_combat.emit(enemy)
			)
			
func _ready() -> void:
	_connect_signal_from_children()
