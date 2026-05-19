class_name potion_class extends item_class

@export var potion_data : potion_base_resource

func _ready() -> void:
	texture.texture = potion_data.potion_sprite
