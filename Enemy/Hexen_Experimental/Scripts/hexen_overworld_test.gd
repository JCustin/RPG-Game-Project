extends CharacterBody2D
var combat_scene = preload("uid://d0wnrtjiu433m") # hexen_combat_test.tscn

var overworld_behavior = overworld_enemy_class.new(self)
var patrol : bool  = false
var patrol_time_limit : int = 100

func _physics_process(delta: float) -> void:
	velocity  = overworld_behavior.patrol()
	move_and_slide()
