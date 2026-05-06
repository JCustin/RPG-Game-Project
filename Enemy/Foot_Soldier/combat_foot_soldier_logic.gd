class_name combat_foot_soldier extends combat_enemy_character
@export var body_part_handler : body_part_handler_component


func _ready() -> void:
	unit_name = "Foot Soldier"
	unit_description = "Sample text"
	var body_parts = body_part_handler.return_body_parts()
	print_debug(body_parts)
