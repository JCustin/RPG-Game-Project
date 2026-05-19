class_name potion_base_resource extends Resource

enum modifier_types {add, subtract, multiply, divide}

@export var modifier : modifier_types
@export var modification_value : int 
@export var usable_in_combat: bool 
@export var potion_sprite : CompressedTexture2D
