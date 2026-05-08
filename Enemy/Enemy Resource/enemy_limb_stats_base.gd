class_name enemy_limb_stats_base extends Resource

signal limb_lost

@export var limb_name : String
@export var limb_type: global_enums.limb_types
@export var limb_HP: int

@export var front_texture: CompressedTexture2D
@export var rear_texture: CompressedTexture2D
@export var limb_direction : global_enums.limb_direction
