class_name combat_describer extends Label
@export var parent_panel : Panel

signal combat_description_closed
var message_id : float

var message_queue : Array

func prompt_combat_description(message: String) -> void:
	message_id = randf_range(1, 1000000)
	var recorded_message_id = message_id
	message_queue.append(message_id)
	
	parent_panel.visible = true
	text = message
	
	#_set_prompt_window_timer(recorded_message_id)
	
	
func _set_prompt_window_timer(recorded_message_id: float) -> void:
	await get_tree().create_timer(2.0).timeout
	if message_queue.size() > 0:
		if recorded_message_id == message_queue[0]:
			force_close_combat_description()
	else:
		pass
		
func force_close_combat_description() -> void:
	parent_panel.visible = false
	combat_description_closed.emit()
	message_queue.pop_front()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("Exit_GUI") or Input.is_key_pressed(KEY_SPACE) and parent_panel.visible == true:
		force_close_combat_description()
