class_name npc_statblock_resource extends Resource
enum faction {empire, neutral, haven}


@export var unit_name : String
@export var unit_description : String
@export var max_HP: int
@export var HP: int
@export var DEF: int 
@export var SPD: int
@export var faction_alliance : faction
