class_name special_skill_resource extends combat_skill_resource

@export_group("COST")
@export var wrath_cost : int
@export var tranqulity_cost : int
@export var bravery_cost : int

@export_group("SKILL TYPE")
enum possible_skill_type {DAMAGING, HEALING, BUFFING, DEBUFFING}
@export var skill_type : possible_skill_type
@export var skill_value : int
