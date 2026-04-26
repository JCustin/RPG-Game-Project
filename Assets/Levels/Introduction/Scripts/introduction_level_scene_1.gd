extends Node2D

func _ready() -> void:
	var obstructions = get_child(-1)
	obstructions.add_to_group('Obstructions')
