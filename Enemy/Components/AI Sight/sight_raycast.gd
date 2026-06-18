class_name sight_raycaster extends RayCast2D
#
#signal player_spotted(player)
#signal player_left_sight(player)
#
#var spotted_player_flag : bool
#var spotted_cooldown : int 
#
#
#func _physics_process(delta: float) -> void:
	#if is_colliding() and spotted_player_flag == false:
		#player_spotted.emit(get_collider())
		#spotted_player_flag = true
		#
	#if spotted_player_flag == true:
		#spotted_cooldown += 1
		#
	#if spotted_cooldown >= 50:
		#spotted_player_flag = false
