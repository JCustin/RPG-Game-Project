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

	acting_enemy.overworld_behavior.initiate_combat(acting_enemy)
	
	var combat_scene = preload("uid://buylh0rmqi1ll").instantiate()
	combat_scene.custom_initialize(acting_enemy)
	add_child(combat_scene)
	combat_scene.combat_complete.connect(end_combat)
	
	%Overworld.visible = false
	%Camera.enabled = false	

func end_combat(victory: bool):
	%Overworld.visible = true
	%Camera.enabled = true
	%Player.end_combat()
	
	if victory == true:
		acting_enemy.free()
	else:
		await get_tree().create_timer(1.0).timeout
		acting_enemy.overworld_behavior.end_fled_combat(acting_enemy)
