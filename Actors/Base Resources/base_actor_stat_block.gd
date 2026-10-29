class_name base_actor_stat_block extends Resource

# this stat_block is based on the current 
# mana-based resource system for combat

@export_group("Basic", "basic_")
@export var basic_HP : int 
@export var basic_combat_unit : PackedScene

@export_group("Combat", "combat_")
@export var combat_basic_attack_value: int
@export var combat_wrath_generation : int
@export var combat_tranquility_generation: int
@export var combat_bravery_generation: int 
@export var combat_skill_pool : actor_skill_pool_resource
@export var combat_default_attack : basic_attack_resource

@export_group("Movement", "movement_")
@export var movement_speed: int
