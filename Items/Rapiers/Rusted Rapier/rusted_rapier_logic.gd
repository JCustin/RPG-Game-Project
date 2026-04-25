extends Node2D
var stat_block = rusted_rapier_datablock.new()

var ATK: int 
var item_name: String
var item_weight: int
var item_value: int
var durability: int
var item_description: String

func _ready() -> void:
	ATK = stat_block.ATK_addition
	item_name = stat_block.item_name
	item_weight = stat_block.item_weight
	item_value = stat_block.item_value
	item_description = stat_block.item_description
