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
	acting_enemy.initiate_combat()
	
	var combat_scene = preload("res://Assets/Levels/Test Scenes/combat_scene.tscn").instantiate()
	if len(get_children()) < 2:
		add_child(combat_scene)
	combat_scene = get_child(-1).get_child(0)
	combat_scene.combat_end.connect(resume_overworld)
	
	%Overworld.visible = false
	%Camera.enabled = false
	
	

func resume_overworld():
	%Overworld.visible = true
	%Camera.enabled = true
	for enemy in get_tree().get_nodes_in_group('Combat_Enemies'):
		enemy.end_combat()
	%Player.end_combat()
