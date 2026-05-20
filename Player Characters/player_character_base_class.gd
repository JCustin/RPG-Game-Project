extends CharacterBody2D 
class_name player_character

var combat_counterpart : combat_player_character
@export var stat_block : player_stat_block_resource


func _init() -> void:
	add_to_group('Player')
	

func talk_to_npc(NPC) -> void:
	pass
	
