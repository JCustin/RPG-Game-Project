extends Node2D

var facing_forward : bool = true
#var stat_blocks 
#var body_stats = stat_blocks.body_stat_block
#var right_arm_stats = stat_blocks.right_arm_stat_block

var front_facing_body_parts : Dictionary
var rear_facing_body_parts : Dictionary

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

func tackle(target):
	attack.emit(target, 10, "The hexen strikes at you.")

func choose_attack(target):
	tackle(target)
