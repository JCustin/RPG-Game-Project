extends Node
class_name overworld_enemy_patrol

var recorded_velocity : Vector2
var patrol_direction: Vector2
var patrol_timer: int
var possible_directions: Array = [Vector2.LEFT, Vector2.UP, Vector2.DOWN, Vector2.RIGHT]
var current_direction : Vector2 = Vector2.ZERO

func patrol(enemy: CharacterBody2D) -> Vector2:
	if patrol_timer <= 40:
		if current_direction == Vector2.ZERO:
			current_direction = possible_directions.pick_random()
			return Vector2.ZERO
		else:
			recorded_velocity = current_direction * enemy.movement_speed
			patrol_timer += 1
			return recorded_velocity 
	else:
		patrol_timer = 0
		current_direction = Vector2.ZERO
		recorded_velocity = Vector2.ZERO
		return recorded_velocity
		

func initiate_combat(enemy: CharacterBody2D) -> void:
	enemy.patrol = false
	for child in enemy.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = true

func end_fled_combat(enemy: CharacterBody2D):
	enemy.patrol = true
	#var tween = enemy.create_tween()
	#tween.set_loops(2)
	#tween.tween_property(enemy, "visible", 0, 1.0)
	#tween.tween_property(enemy, "visible", 1.0, 1.0)
	for child in enemy.get_children():
		if child.is_class('CollisionShape2D'):
			child.disabled = false
