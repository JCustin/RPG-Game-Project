class_name player_movement_controller extends Node
@export var object_raycast_detector : RayCast2D

signal movement_direction(direction: Vector2)

func _input(event: InputEvent):
	var direction = Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	movement_direction.emit(direction)
	
	if Input.is_action_just_pressed("Movement_Left"):
		object_raycast_detector.rotation_degrees = 90
	if Input.is_action_just_pressed("Movement_Right"):
		object_raycast_detector.rotation_degrees = -90
	if Input.is_action_just_pressed("Movement_Up"):
		object_raycast_detector.rotation_degrees = 180
	if Input.is_action_just_pressed("Movement_Down"):
		object_raycast_detector.rotation_degrees = 0
		
