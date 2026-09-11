class_name base_actor_stat_block extends Resource

# this stat_block is based on the current 
# mana-based resource system for combat

@export var HP: int
@export var combat_unit : PackedScene
@export var wrath_generation: int
@export var bravery_generation: int
@export var discipline_generation: int
@export var movement_speed : int
