extends Node2D
var acting_enemy: Node2D

func _ready() -> void:
	%Player.contacted_enemy.connect(initiate_combat)

func _physics_process(delta: float) -> void:
	%Camera.position = %Player.position
	
func initiate_combat(enemy_node: Node2D):
	%Player.initiate_combat()
	acting_enemy = enemy_node
	acting_enemy.add_to_group('Combat_Enemies')
	acting_enemy.overworld_behavior.initiate_combat()
	
	var combat_scene = preload("uid://buylh0rmqi1ll").instantiate()
	combat_scene.custom_initialize(acting_enemy)
	add_child(combat_scene)
	combat_scene.combat_complete.connect(resume_overworld)
	
	#combat_scene.end_combat.connect(resume_overworld)
	#if len(get_children()) < 2:
		#add_child(combat_scene)
	#combat_scene.end_combat.connect(resume_overworld)
	
	%Overworld.visible = false
	%Camera.enabled = false	

func resume_overworld():
	%Overworld.visible = true
	%Camera.enabled = true
	# TODO create a function for the enemy to handle their deletion. 
	acting_enemy.free()
	%Player.end_combat()
