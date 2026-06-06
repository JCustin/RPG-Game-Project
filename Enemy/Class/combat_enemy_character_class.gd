class_name combat_enemy_character extends Node2D

@export var unit_name : String
@export var unit_description : String
@export var stat_block : enemy_stat_block_resource

@export var attack_pool : Array[base_enemy_attack_structure]
@export var combat_dialogue_options : DialogicTimeline

@export var limbs : Array[enemy_limb_class]

# if a primary_limb is destroyed, then the whole damn thing is done for. 
@export var primary_limb: enemy_limb_class

var queued_actions : Array = []

signal executed_attack(target: combat_player_character, attack_damage: int, attack_type: StringName, combat_description: String)
signal enemy_defeated
signal enemy_wounded


func _ready() -> void:
	connect_signals()

func connect_signals():
	for limb : enemy_limb_class in limbs:
		limb.limb_lost.connect(_lose_limb)

func _choose_target(player_pool : Array) -> combat_player_character:
	var weakest_player : combat_player_character = player_pool[0]
	for player : combat_player_character in player_pool:
		if player.stat_block.HP < weakest_player.stat_block.HP:
			weakest_player = player
	return weakest_player
	
func _choose_attack(_target: combat_player_character) -> base_enemy_attack_structure:
	var selected_attack : base_enemy_attack_structure = attack_pool.pick_random()
	return selected_attack

func prepare_action(player_pool : Array) -> Dictionary:
	var attack_data : Dictionary = {}
	var target = _choose_target(player_pool)
	attack_data["target"] = target
	attack_data["attack"] = _choose_attack(target)
	
	return attack_data
	 
func execute_turn(player_pool: Array) -> void:
	
	var target = _choose_target(player_pool)
	var attack_stats : base_enemy_attack_structure = _choose_attack(target)
	var attack_damage : int = attack_stats.attack_damage + stat_block.ATK
	var attack_description : String = attack_stats.attack_description
	var attack_type : global_enums.damage_type = attack_stats.damage_type
	
	executed_attack.emit(target, attack_damage, attack_type, attack_description)

func get_limbs_based_on_combat_direction(direction: global_enums.combat_direction) -> Array:
	var possible_combat_direction = global_enums.combat_direction
	var possible_limb_direction = global_enums.limb_direction
	var limbs_pool : Array
	
	match direction:
		possible_combat_direction.forward:
			for limb : enemy_limb_class in limbs:
				
				var limb_direction = limb.stat_block.limb_direction
				match limb_direction:
					
					possible_limb_direction.forward_only:
						limbs_pool.append(limb)
					possible_limb_direction.rear_only:
						pass
					possible_limb_direction.both:
						limbs_pool.append(limb)
		
		possible_combat_direction.rear:
			for limb : enemy_limb_class in limbs:
				var limb_direction = limb.stat_block.limb_direction
				match limb_direction:
					
					possible_limb_direction.forward_only:
						pass
					possible_limb_direction.rear_only:
						limbs_pool.append(limb)
					possible_limb_direction.both:
						limbs_pool.append(limb)
					
	return limbs_pool

func _lose_limb(limb: enemy_limb_class) -> void:
	limbs.erase(limb)
	limb.kill_limb()
	
	if limb == primary_limb:
		enemy_defeated.emit()
		
	else:
		enemy_wounded.emit()
		
func switch_direction(direction: global_enums.combat_direction) -> void:
	var combat_direction = global_enums.combat_direction
	match direction:
		
		combat_direction.forward:
			for limb in limbs:
				limb.switch_direction(combat_direction.forward)
			
			
		combat_direction.rear:
			for limb in limbs:
				limb.switch_direction(combat_direction.rear)
	
