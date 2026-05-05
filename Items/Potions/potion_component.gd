class_name potion_component extends Node


func use_potion(affected_stat: int, potion_modifier: int) -> int:
	var modified_stat = affected_stat + potion_modifier
	return modified_stat
	
# TODO - implement code for 'throwing' a potion at a target so they could get hit. 
@warning_ignore("unused_parameter")
func throw_potion_at_target(target: CharacterBody2D, potion_effect: String):
	pass
