class_name player_3d_movement_controller extends Node
@export var player : player_actor_class
var active_flag : bool = true
var movement_speed : int

var direction: Vector3

func _ready() -> void:
	movement_speed = player.stat_block.movement_speed

func _input(event: InputEvent) -> void:
	if event.is_action("Movement_Left"):
		direction = Vector3.LEFT
	
	if event.is_action("Movement_Right"):
		direction = Vector3.RIGHT
		
	if event.is_action("Movement_Up"):
		direction = Vector3(0, 0, -1.0)
		
	if event.is_action("Movement_Down"):
		direction = Vector3(0,0, 1.0)
		
	player.velocity = direction * movement_speed

func _physics_process(_delta: float) -> void:
	player.move_and_slide()
