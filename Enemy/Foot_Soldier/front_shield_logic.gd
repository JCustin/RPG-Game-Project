extends Node2D
var stat_block = foot_soldier_shield_stat_block.new()

var HP : int
var DEF: int

var rear_counterpart: Node2D 

func _ready() -> void:
	HP = stat_block.HP
	DEF = stat_block.DEF
	rear_counterpart = %Rear_Shield
	
func sync_damage():
	rear_counterpart.HP = HP
