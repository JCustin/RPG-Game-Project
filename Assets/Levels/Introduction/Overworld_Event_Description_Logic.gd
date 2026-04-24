extends Panel

var overworld_event_describer : Label

func _ready() -> void:
	overworld_event_describer = get_child(0)
	var player = get_tree().get_first_node_in_group('Player')
	player.prompt_overworld_event_description.connect(display_overworld_event_description)
	
func display_overworld_event_description(description: String):
	visible = true
	overworld_event_describer.text = description
	await get_tree().create_timer(2.0).timeout
	visible = false
