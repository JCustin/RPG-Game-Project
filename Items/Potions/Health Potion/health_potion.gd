extends StaticBody2D

@export var potion_behavior: potion_component

var item_name = "Health Potion"
var item_type = "Potion"

@export var healing_amount : int = 20


func _ready() -> void:
	add_to_group('Potion')
	add_to_group('Health_Potion')
	
func drink_potion(HP: int):
	var new_HP = potion_behavior.use_potion(HP, healing_amount)
	return new_HP
	
