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
	#print_debug(thumbnail.get_meta('turn_data'))
	turn_data_panel.visible = true
	turn_data_panel.position = get_global_mouse_position()
	turn_data_panel.position.y += 30
	var turn_data_text : Label = turn_data_panel.get_child(0)
	turn_data_text.text = 'help'
	
	
	
func hide_turn_information(thumbnail : combat_thumbnail_image) -> void:
	turn_data_panel.visible = false
	
func clear_hud() -> void:
	for child in turn_queue_container.get_children():
		child.queue_free()
