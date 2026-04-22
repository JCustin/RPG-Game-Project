extends Node2D
var stat_block = foot_soldier_statblocks.new()

var HP : int
var DEF: int

var counterpart: Node2D

func _ready() -> void:
	#HP = stat_block.shield_stat_block["HP"]
	HP = 10
	DEF = stat_block.shield_stat_block["DEF"]
	
