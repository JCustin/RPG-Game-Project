class_name enemy_character extends CharacterBody2D

var combat_counterpart : PackedScene
var unit_name : String
var unit_description : String

func _init() -> void:
	set_collision_layer_value(3, true)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, true)
	z_index = 10
