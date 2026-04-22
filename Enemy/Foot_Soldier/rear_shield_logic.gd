extends Node2D
var HP: int
var DEF: int

var counterpart: Node2D

func _ready() -> void:
	HP = %Front_Shield.HP
	DEF = %Front_Shield.DEF
	
	counterpart = %Front_Shield

func sync_damage():
	counterpart.HP = HP
