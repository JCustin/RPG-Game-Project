class_name gamecamera extends Camera3D

@export var player_manager : player_controller_manager
var player : player_actor_class

enum camera_states {overworld, combat}
var state : camera_states = camera_states.overworld

func _ready() -> void:
	player = player_manager.player

func _move_camera_per_status():
	match state:
		
		camera_states.overworld:
			reparent(player)
			
		camera_states.combat:
			pass
		
