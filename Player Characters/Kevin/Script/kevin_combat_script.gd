extends Node2D
var HP: int = 100
var ATK: int = 10
var DEF : int = 3
var SPD : int = 1
var STAM: int = 100
	#set(value):
		#stamina_changed.emit(value)
var partial_stamina_recovery_value: int = 10

var alive : bool = true

var facing_forward: bool = true

signal stamina_changed(stamina_change_value: int)
signal attack(attack_value: int, attack_description: String)


func _ready() -> void:
	add_to_group('Fighting_Player')
	
func basic_attack(target_enemy):
	attack.emit(target_enemy, ATK + 10, "Witch Hunter thrusts forward with a strong jab.")
	expend_stamina(30)

func flank():
	expend_stamina(30)
	
func expend_stamina(stamina_cost: int) -> void:
	STAM -= stamina_cost
	stamina_changed.emit(STAM)

func restore_partial_stamina():
	STAM += partial_stamina_recovery_value
	if STAM > 100:
		STAM = 100
	stamina_changed.emit(STAM)

func validate_stamina_cost(stamina_cost: int) -> bool:
	if (STAM - stamina_cost) > 0:
		return true
	else:
		return false

func validate_basic_attack_stamina_cost() -> bool:
	return validate_stamina_cost(30)
