class_name dialogue_component extends Node

@export var dialogue : DialogicTimeline



func _ready() -> void:
	Player_Data.dialogue_started.connect(start_dialogue)
	Dialogic.timeline_ended.connect(stop_dialogue)
	
func start_dialogue(npc_talking: npc_character_class):
	if npc_talking == get_parent():
		Dialogic.start(dialogue)
		
func stop_dialogue():
	print_debug("TEST")
