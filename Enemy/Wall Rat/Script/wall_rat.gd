extends Node2D

var health_stat: int = 100
var stats = wall_rat_stats.new()
var most_vulnerable_target: Node2D
var unit_id = "Wall_Rat"
var unit_name = "Wall Rat"

signal attack(target: Node2D, attack_value: int, combat_description: TextParagraph)

func _ready() -> void:
	add_to_group('Enemy')
	position = Vector2(0, -150)

func tackle():
	attack.emit(most_vulnerable_target, (stats.attack + 10), "The wall rat slams its wide-set body against you!")
	print('tackle was selected')
	
func block_out():
	attack.emit(most_vulnerable_target, (stats.attack + 20), "The wall rat blocks you out!")
	print('block_out was selected')
	
func wait():
	attack.emit(most_vulnerable_target, 0, "The wall rat waits...for what?")
	
func roar():
	attack.emit(most_vulnerable_target, stats.attack, "The wall rat roars! The ferocity of its war cry aches your ears.")

func choose_attack(potential_targets: Array):
	var possible_attacks: Array = ["tackle", "block_out", "wait", "roar"]
	most_vulnerable_target = potential_targets[0]
	
	#for potential_target_actor in potential_targets:
		#if potential_target_actor.health_stat < 100:
			#most_vulnerable_target = potential_target_actor
		#
		#
	#if most_vulnerable_target.health_stat > 50:
		#possible_attacks.erase("wait")
		#possible_attacks.erase("roar")
	
	var random_attack = possible_attacks.pick_random()
	
	if random_attack == "tackle":
		tackle()
	elif random_attack == "block_out":
		block_out()
	elif random_attack == "wait":
		wait()
	elif random_attack == "roar":
		roar()
