class_name combat_describer extends Label
@export var parent_panel : Panel

signal combat_description_closed


func prompt_combat_description(message: String) -> void:
	parent_panel.visible = true
	text = message
	#await get_tree().create_timer(4.0).timeout
	#if parent_panel.visible == true and text == message:
		#force_close_combat_description()
	
func force_close_combat_description() -> void:
	parent_panel.visible = false
	combat_description_closed.emit()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("Exit_GUI") or Input.is_key_pressed(KEY_SPACE) and parent_panel.visible == true:
		text = ' '
		parent_panel.visible = false
		combat_description_closed.emit()
