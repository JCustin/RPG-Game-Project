extends AnimatedSprite3D
var parent_node : player_actor_class

func _ready() -> void:
	parent_node = get_parent()


func _input(event: InputEvent) -> void:
	if event.is_released():
		animation = "Idle"
		
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Movement_Down"):
		animation = "Move South"
		
	if Input.is_action_just_pressed("Movement_Up"):
		animation = "Move North"
	
	if parent_node.is_on_floor() == false:
		animation = "Rear Jump"
