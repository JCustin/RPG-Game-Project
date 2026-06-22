class_name turn_queue_HUD extends Control

@export var turn_data_panel : Panel
@export var turn_data_text : Label
@export var turn_queue_container : HBoxContainer



func add_thumbnail(queued_turn_data : Dictionary):
	var actor = queued_turn_data["actor"]
	var turn_count = queued_turn_data["turn_count"]
	var queued_action = queued_turn_data["queued_action"]
	var thumbnail = combat_thumbnail_image.new()
	turn_queue_container.add_child(thumbnail)
	thumbnail.texture = actor.thumbnail_image
	thumbnail.set_meta('turn_data', queued_turn_data)
	thumbnail.display_turn_information.connect(display_turn_information)
	thumbnail.hide_turn_information.connect(hide_turn_information)

func remove_latest_thumbnail() -> void:
	turn_queue_container.get_child(0).queue_free()

func display_turn_information(thumbnail : combat_thumbnail_image) -> void:
	var turn_data = thumbnail.get_meta('turn_data')
	var queued_action = turn_data["queued_action"]
	
	var turn_data_text_variables = {}
	
	if queued_action["target"] != null:
		var acting_enemy : combat_enemy_character = turn_data["actor"]
		turn_data_text_variables["actor"] = acting_enemy.unit_name
		
		
		var queued_attack : base_enemy_attack_structure = queued_action["attack"]
		var queued_attack_target : combat_player_character = queued_action["target"]
		
		var turn_count : int = turn_data["turn_count"]
		
		turn_data_text_variables["attack"] = queued_attack.attack_name
		turn_data_text_variables["target"] = queued_attack_target.name
		turn_data_text_variables["turn_count"] = turn_count
		
		turn_data_panel.visible = true
		turn_data_panel.position = get_local_mouse_position()
		turn_data_panel.position.y += 30
		
		turn_data_text.text = str(
			'actor: {actor},
			turn count: {turn_count},
			attack: {attack},
			target: {target}'
		).format(turn_data_text_variables)

	
func hide_turn_information(thumbnail : combat_thumbnail_image) -> void:
	turn_data_panel.visible = false
	
func clear_hud() -> void:
	for child in turn_queue_container.get_children():
		child.queue_free()
