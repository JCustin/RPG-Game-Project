class_name basic_attack_combat_component extends Node

signal basic_attack_performed(target)
signal basic_attack_aborted 

var target_selector : combat_target_selection_logic

func init_possible_targets(target_list: Array):
	target_selector = combat_target_selection_logic.new(target_list)
	add_child(target_selector)
	
	target_selector.target_selected.connect(execute_attack)
	target_selector.target_selection_aborted.connect(abort_basic_attack)
	
func abort_basic_attack():
	basic_attack_aborted.emit()
	queue_free()

func execute_attack(target):
	basic_attack_performed.emit(target)
	queue_free()
