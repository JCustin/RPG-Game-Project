extends CharacterBody2D

@export var patrol_time_limit: int = 100.00
var overworld_behavior = overworld_enemy_class.new(self)
var patrol : bool  = false

#var combat_unit_counterpart = preload("uid://c7gn0k5q18gyc") # combat_wild_mummo

var combat_unit_counterpart = preload("uid://dr5bfgnwws2pj") # TESTING
func _ready() -> void:
	add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	velocity = overworld_behavior.patrol()
	move_and_slide()
	
