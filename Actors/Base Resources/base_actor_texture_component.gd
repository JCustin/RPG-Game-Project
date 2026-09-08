class_name base_actor_texture_component extends AnimatedSprite3D

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Movement_Up"):
		play("Walk North")
	
	if Input.is_action_just_pressed("Movement_Down"):
		play("Walk South")
	
	if Input.is_action_just_pressed("Movement_Left"):
		play("Walk West")
		
	if Input.is_action_just_pressed("Movement_Right"):
		play("Walk East")
