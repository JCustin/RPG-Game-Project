class_name combat_skill_resource extends Resource

@export_category("TEXT")
@export var TEXT_skill_name : String
@export var TEXT_skill_desc : String
@export var TEXT_skill_action_desc : String # displayed in combat

@export_group("COMBAT DATA")
enum possible_skill_type {DAMAGING, HEALING, BUFFING, DEBUFFING}
@export var skill_type : possible_skill_type
@export var skill_value : int

@export_group("COST")
@export var wrath_cost : int
@export var tranqulity_cost : int
@export var bravery_cost : int
