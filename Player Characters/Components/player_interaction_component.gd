class_name player_interaction_component extends Node
@export var raycast_detector: RayCast2D

signal player_picked_up_item(item: StaticBody2D)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if raycast_detector.is_colliding():
			var item : Variant = raycast_detector.get_collider()
			
			if item is item_class:
				pick_up_item(item)
				
			if item is npc_character_class:
				Player_Data.dialogue_started.emit(item)
				
			else:
				pass
		else:
			pass

func pick_up_item(item: StaticBody2D):
	player_picked_up_item.emit(item)
	
	
#TODO - expand code for player interacting with objects in the scene
# maybe code to look at a metadata to determine the type of object? 
# rather than assume it is always a StaticBody2D
