extends Node2D
var HP: int = 100
var ATK: int = 10
var DEF : int = 3
var SPD : int = 1

var alive : bool = true

var facing_forward: bool = true

signal attack(attack_value: int, attack_description: String)

func _ready() -> void:
	add_to_group('Fighting_Player')

func basic_attack(target_enemy):
	attack.emit(target_enemy, ATK + 10, "Witch Hunter thrusts forward with a strong jab.")
