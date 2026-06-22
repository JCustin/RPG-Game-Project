class_name combat_initation_component extends Node

#@export var hurtbox : CollisionShape2D
@export var player : player_character

signal contacted_enemy(enemy: CharacterBody2D)
signal contacted_trap(trap: StaticBody2D) # later, change this to be the trap_item datatype. 



var active : bool = true

func _ready() -> void:
	Player_Data.combat_ended.connect(func(): active = true)

func _physics_process(_delta: float) -> void:
	if player.get_last_slide_collision() != null and active == true:
		identify_collider(player.get_last_slide_collision())

func identify_collider(collision :  KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	var collidier_type = collider.get_class()
	#print_debug(collidier_type)
	if collidier_type == "StaticBody2D":
		pass
	if collider is enemy_character:
		Player_Data.combat_initiated.emit(player, collider)
		active = false
