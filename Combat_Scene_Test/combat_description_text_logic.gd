class_name combat_describer extends Label
@export var parent_panel : Panel

signal combat_description_closed


func prompt_combat_description(message: String) -> void:
	parent_panel.visible = true
	text = message
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit_GUI") and parent_panel.visible == true:
		text = ' '
		parent_panel.visible = false
		combat_description_closed.emit()
