class_name base_player_combatant extends StaticBody3D

@export var sprite : AnimatedSprite3D

# the utility of the code below is yet to be seen.
# perhaps a parent combat manager can handle turn sequence?
enum all_combat_states {TURN_ACTIVE, TURN_INACTIVE, DEAD}
var current_combat_state : all_combat_states = all_combat_states.TURN_ACTIVE
# # # # 

var stat_block : base_actor_stat_block

# function to carry over the stat_block from the main actor.
# question is, will the final implementation be the responsibility
# of the combatant? Or a parent node that orchestrates 
# it all...

func assign_stat_block(actor: base_player_actor):
	stat_block = actor.stat_block.duplicate()
	# we create a duplicate because changes to the 
	# stats in combat should not be made permanent 
	# into the overworld. 
	
