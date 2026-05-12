class_name basic_attack_combat_component extends Node

signal basic_attack_performed(basic_attack_target)
signal basic_attack_aborted 

var tween_controller : Tween

var target
var target_index : int = 0

var target_pool : Array

func init_possible_targets(target_list: Array):
	print_debug(target_list)
	target_pool = target_list
	set_target(target_pool[target_index])

func set_target(new_target):
	if target != null:
		unhighlight_enemy(target)
		
	target = new_target
	target_index = target_pool.find(target)
	highlight_enemy(target)
	
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Movement_Left"):
		
		if (target_index - 1) < 0:
			set_target(target_pool[-1])
		else:
			set_target(target_pool[target_index - 1])
			
	if event.is_action_pressed("Movement_Right"):
		if (target_index + 1) >= target_pool.size():
			set_target(target_pool[0])
		else:
			set_target(target_pool[target_index + 1])
	
	if event.is_action_pressed("Exit_GUI"):
		abort_basic_attack()
		
		
	if event.is_action("ui_accept"):
		select_attack()
		
func trigger_target_select():
	target = target_pool[0]
			
func highlight_enemy(enemy):
	tween_controller = enemy.create_tween()
	tween_controller.set_loops()
	tween_controller.tween_property(enemy, "modulate", Color.RED, 0.5)
	tween_controller.tween_property(enemy, "modulate", Color.WHITE, 0.5)
	
func unhighlight_enemy(enemy):
	tween_controller.kill()
	enemy.modulate = Color(1.0, 1.0, 1.0)
	
func abort_basic_attack():
	basic_attack_aborted.emit()
	unhighlight_enemy(target)
	queue_free()

func select_attack():
	unhighlight_enemy(target)
	basic_attack_performed.emit(target)
	queue_free()
