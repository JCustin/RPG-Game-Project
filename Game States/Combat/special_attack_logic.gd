class_name combat_special_attack_component extends Node

var player : combat_player_character
var target_selector : combat_target_selection_logic

signal special_attack_aborted
signal special_attack_executed(
	target, 
	attack_damage: int, 
	attack_type: String, 
	attack_description: String
)

func _init(active_actor : combat_player_character, target_pool: Array) -> void:
	player = active_actor
	target_selector = combat_target_selection_logic.new(target_pool)
	add_child(target_selector)
	target_selector.target_selection_aborted.connect(queue_free)
