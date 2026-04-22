extends Node2D

var stat_block = foot_soldier_statblocks.new()

var HP: int 
var DEF: int
var SPD: int
var ATK: int

var counterpart: Node2D

func _ready() -> void:
	HP = stat_block.body_stat_block["HP"]
	DEF = stat_block.body_stat_block["DEF"]
	ATK = stat_block.body_stat_block["ATK"]
