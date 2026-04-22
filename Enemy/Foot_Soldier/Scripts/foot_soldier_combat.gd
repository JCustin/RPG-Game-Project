extends Node2D

var facing_forward : bool = true
var stat_block = foot_soldier_statblocks.new()
var alive : bool = true

#var body_stats = stat_blocks.body_stat_block
#var right_arm_stats = stat_blocks.right_arm_stat_block

@export var SPD : int = 10


var front_facing_body_parts : Array
var rear_facing_body_parts : Array

signal attack
signal defeated

func _ready() -> void:
	front_facing_body_parts = [
		%Shield,
		%Body,
		%Sword
	]
	#debug("The HP of the Hexen's right arm is: ", right_arm_stats["HP"])

	rear_facing_body_parts = [
		%Body,
		%Shield
	]


func remove_body_part(body_part: Node2D) -> void:
	var tween_controller = Tween
	tween_controller = body_part.create_tween()
	
	tween_controller.tween_property(body_part, "scale", Vector2(1.2, 1.2), 0.4)
	tween_controller.tween_property(body_part, "scale", Vector2(0.0, 0.0), 0.3)
	tween_controller.parallel()
	tween_controller.tween_property(body_part, "modulate", Color.BROWN, 0.3)
	tween_controller.tween_callback(body_part.queue_free)
	

	front_facing_body_parts.erase(body_part)
	rear_facing_body_parts.erase(body_part)
	
	if body_part == %Body:
		defeated.emit()
		alive = false
	
	if facing_forward == true:
		front_facing_body_parts.erase(body_part)
	else:
		rear_facing_body_parts.erase(body_part)
		

func change_position_by_combat_direction(forward_combat_direction: bool):
	if forward_combat_direction == true:
		for node in get_tree().get_nodes_in_group('Front_Limb'):
			node.visible = true
		for node in get_tree().get_nodes_in_group('Rear_Limb'):
			node.visible = false
			
	else:
		for node in get_tree().get_nodes_in_group('Front_Limb'):
			node.visible = false
		for node in get_tree().get_nodes_in_group('Rear_Limb'):
			node.visible = true


func tackle(target):
	attack.emit(target, 10, "The hexen strikes at you.")

func choose_attack(target):
	tackle(target)
