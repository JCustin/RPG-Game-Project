class_name player_combat_initiator extends Node

@export var hurtbox : CollisionShape3D
@export var player : player_actor_class

signal contacted_enemy(enemy: enemy_actor_class)
signal contacted_trap(trap: StaticBody2D) # later, change this to be the trap_item datatype. 

var active : bool = true

func _ready() -> void:
	Player_Data.combat_ended.connect(func(): active = true)
	
#func _physics_process(delta: float) -> void:
	#if player.get_last_slide_collision() != null and active == true:
		#
		##print_debug(player.get_last_slide_collision().get_collision_count())
		#if player.get_last_slide_collision().get_collision_count() > 4:
			#var collision_event : KinematicCollision3D = player.get_last_slide_collision()
			#var curtailed_collision_count = (collision_event.get_collision_count() - 4)
			#
			#for collision_index in range(curtailed_collision_count):
				#var collider = collision_event.get_collider(-collision_index)
				#if collider is enemy_actor_class:
					#contacted_enemy.emit(collider)
					#active = false
				#else:
					#pass
					
#func identify_collider(collision :  KinematicCollision2D) -> void:
	#var collider = collision.get_collider()
	#var collidier_type = collider.get_class()
	##print_debug(collidier_type)
	#if collidier_type == "StaticBody2D":
		#pass
	#if collider is enemy_character:
		#Player_Data.combat_initiated.emit(player, collider)
		#active = false
