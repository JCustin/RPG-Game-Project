extends CharacterBody2D 
class_name player_character

var HP: int
var max_HP : int 
var STAM : int
var max_STAM : int
var DEF: int 
var SPD: int 
var ATK: int

func _init() -> void:
	add_to_group('Player')
	
