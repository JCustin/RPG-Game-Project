class_name combat_target_selection_logic extends Node

var target_pool : Array
var target_index : int = 0
var target : enemy_limb_class
var tween_controller = Tween

signal target_selected(target)
signal target_selection_aborted

func _init(targets: Array) -> void:
	target_pool = targets
	set_target(targets[0])
	
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
		unhighlight_enemy(target)
		target_selection_aborted.emit()
		
		
	if event.is_action_pressed("ui_accept"):
		unhighlight_enemy(target)
		target_selected.emit(target)
			
func set_target(new_target):
	if target != null:
		unhighlight_enemy(target)
		
	target = new_target
	target_index = target_pool.find(target)
	highlight_enemy(target)
	
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
