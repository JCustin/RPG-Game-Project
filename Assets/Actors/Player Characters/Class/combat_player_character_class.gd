class_name combat_player_character extends Node2D

signal executed_attack(
target, 
attack_damage: int, 
attack_type: StringName, 
combat_description: String)


@export var player_basic_attack_stats : basic_attack_stat_block
@export var player_special_attacks_pool : Array[special_attack_stat_block]
@export var stat_block : player_stat_block_resource
@export var thumbnail_image: CompressedTexture2D

func deal_basic_attack(target):
	executed_attack.emit(
	target,
	player_basic_attack_stats.attack_damage, 
	player_basic_attack_stats.damage_type, 
	player_basic_attack_stats.attack_description,)

#func deal_special_attack(special_attack, target)

func talk_to_enemy(enemy: combat_enemy_character) -> void:
	pass	
