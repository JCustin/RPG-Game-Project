extends StaticBody2D
class_name potion_class

# the use_potion_to_modify_stats function is intended for cases where a potion is 
# used to increase or subtract a stat. The potion_modifier represents the value
# by which the potion is directly affecting the stat. This logic assumes
# that the potion_modifier may either be a positive or negative number.
func use_potion_to_modify_stats(affected_stat: int, potion_modifier: int) -> int:
	var modified_stat = affected_stat + potion_modifier
	return modified_stat
	
# TODO - implement code for 'throwing' a potion at a target so they could get hit. 
func throw_potion_at_target(target: CharacterBody2D, potion_effect: String):
	pass
