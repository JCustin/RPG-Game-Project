extends Node2D
var facing_forward : bool = true
var stat_blocks = hexen_stat_block.new()
var body_stats = stat_blocks.body_stat_block
var right_arm_stats = stat_blocks.right_arm_stat_block

var front_facing_body_parts : Dictionary
var rear_facing_body_parts : Dictionary

signal attack

func _ready() -> void:
	front_facing_body_parts = {
	"body": %Front_Body,
	"right_arm": %Front_Right_Arm
	}
	#debug("The HP of the Hexen's right arm is: ", right_arm_stats["HP"])

func choose_attack(target):
	attack.emit()
