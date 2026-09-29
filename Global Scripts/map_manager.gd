class_name map_manager extends Node

func _ready() -> void:
	%Camera_Switch.body_entered.connect(switch_to_temple_camera)
	%Camera_Switch.body_exited.connect(return_to_main_camera)
	
func switch_to_temple_camera(body) -> void:
	%Temple_Camera.make_current()
	
func return_to_main_camera(body) -> void:
	%Main_Camera.make_current()
