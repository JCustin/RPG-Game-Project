class_name dialogue_component extends Node

@export var dialogue : DialogicTimeline

var dialogue_running : bool = false

func _ready() -> void:
	Player_Data.dialogue_started.connect(start_dialogue)
	Dialogic.timeline_ended.connect(stop_dialogue)
	
func start_dialogue(npc_talking: npc_character_class):
	if npc_talking == get_parent() and dialogue_running == false:
		Dialogic.start(dialogue)
		dialogue_running = true
		
func stop_dialogue():
	dialogue_running = false
