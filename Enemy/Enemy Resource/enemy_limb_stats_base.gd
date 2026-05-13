class_name enemy_limb_stats_base extends Resource

signal limb_lost

@export var limb_name : String
@export var limb_type: global_enums.limb_types
@export var HP: int:
	set(new_HP):
		HP = new_HP
		if new_HP <= 0:
			limb_lost.emit()
			
@export var DEF: int
@export var damage_type_weakness : global_enums.damage_type
@export var front_texture: CompressedTexture2D
@export var rear_texture: CompressedTexture2D
@export var limb_direction : global_enums.limb_direction
