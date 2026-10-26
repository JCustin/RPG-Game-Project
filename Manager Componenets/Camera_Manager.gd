class_name camera_manager_component extends Node

var player : base_player_actor
@export var actor_manager_boss : actor_manager
@export var main_camera : Camera3D


func _ready() -> void:
	await actor_manager_boss.ready
	var player_actor_manager = actor_manager_boss.get_child(0)
	player = player_actor_manager.get_child(0)
	
