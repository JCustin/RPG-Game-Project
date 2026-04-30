extends CharacterBody2D
var combat_scene = preload("uid://bngmobsxtnf54") # hexen_combat_test.tscn

var overworld_behavior = overworld_enemy_patrol.new()
var patrol : bool  = true

@export var movement_speed: int 

func _ready() -> void:
	add_to_group('Enemy')

func _physics_process(delta: float) -> void:
	if patrol == true:
		velocity  = overworld_behavior.patrol(self)
		move_and_slide()
