class_name npc_character_class extends CharacterBody2D

@export var stat_block : npc_statblock_resource

func _ready() -> void:
	add_to_group('NPC')
	set_collision_layer_value(5, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, true)
	set_collision_mask_value(5, true)
