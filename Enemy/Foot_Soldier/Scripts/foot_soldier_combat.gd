extends Node2D

var facing_forward : bool = true
var stat_block = foot_soldier_statblocks.new()

#var body_stats = stat_blocks.body_stat_block
#var right_arm_stats = stat_blocks.right_arm_stat_block

var front_facing_body_parts : Dictionary
var rear_facing_body_parts : Dictionary

var HP: int 
var DEF: int
var SPD: int
var ATK: int


signal attack

func _ready() -> void:
	front_facing_body_parts = {
	"shield": %Front_Shield,
	"body": %Front_Body,
	"sword": %Front_Sword
	}
	#debug("The HP of the Hexen's right arm is: ", right_arm_stats["HP"])

	rear_facing_body_parts = {
		"body": %Rear_Body,
		"shield": %Rear_Shield
	}

	HP = stat_block.body_stat_block["HP"]
	DEF = stat_block.body_stat_block["DEF"]
	SPD = stat_block.body_stat_block["SPD"]
	ATK = stat_block.body_stat_block["ATK"]

func remove_body_part(body_part: Node2D) -> void:
	if facing_forward == true:
		var key = front_facing_body_parts.find_key(body_part)
		front_facing_body_parts.erase(key)
	else:
		var key = rear_facing_body_parts.find_key(body_part)
		rear_facing_body_parts.erase(key)

func tackle(target):
	attack.emit(target, 10, "The hexen strikes at you.")

func choose_attack(target):
	tackle(target)
