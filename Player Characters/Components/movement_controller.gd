class_name player_movement_controller extends Node
var object_raycast_detector : RayCast2D

@export var movement_speed : int 

signal movement_direction(direction: Vector2)

var player: player_character
var in_combat : bool = false

func _ready() -> void:
	player = get_parent()
	
	for child in player.get_children():
		if child.is_class("RayCast2D"):
			object_raycast_detector = child
		else:
			pass
			
	Player_Data.combat_initiated.connect(func(_player, _enemy): in_combat = true)
	Player_Data.combat_ended.connect(func(): in_combat = false)

func _input(_event: InputEvent):
	var direction = Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
	player.velocity = direction * movement_speed

	if object_raycast_detector != null:
		if Input.is_action_just_pressed("Movement_Left"):
			object_raycast_detector.rotation_degrees = 90
		if Input.is_action_just_pressed("Movement_Right"):
			object_raycast_detector.rotation_degrees = -90
		if Input.is_action_just_pressed("Movement_Up"):
			object_raycast_detector.rotation_degrees = 180
		if Input.is_action_just_pressed("Movement_Down"):
			object_raycast_detector.rotation_degrees = 0

func _physics_process(delta: float) -> void:
	if in_combat == false:
		player.move_and_slide()
