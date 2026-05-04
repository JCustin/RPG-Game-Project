class_name player_movement_controller extends Node
@export var object_raycast_detector : RayCast2D

signal movement_direction(direction: Vector2)

func _input(event: InputEvent):
	var direction = Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	movement_direction.emit(direction)
