extends Node2D
var health_stat: int = 100
var attack_stat: int = 10

var facing_forward: bool = true

signal attack(attack_value: int, attack_description: String)

func _ready() -> void:
	add_to_group('Fighting_Player')

func basic_attack(target_enemy):
	attack.emit(target_enemy, attack_stat + 10, "Witch Hunter thrusts forward with a strong jab.")
