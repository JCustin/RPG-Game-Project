extends Node2D

var stat_block = foot_soldier_statblocks.new()

var HP : int
var DEF: int

func _ready() -> void:
	HP = stat_block.body_stat_block["HP"]
	DEF = stat_block.body_stat_block["DEF"]
