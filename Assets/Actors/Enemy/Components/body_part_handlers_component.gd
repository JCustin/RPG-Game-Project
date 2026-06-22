class_name body_part_handler_component extends Node


func return_body_parts() -> Array:
	var all_body_parts : Array
	var all_body_parts_metadata : Array
	
	for direction in get_children():
		for body_part in direction.get_children():
			if all_body_parts_metadata.has(body_part.get_meta("Body_Part_Name")):
				pass
			else:
				all_body_parts.append(body_part)
				all_body_parts_metadata.append(body_part.get_meta("Body_Part_Name"))
				
	return all_body_parts

func remove_body_part(body_part: Sprite2D) -> void:
	var tween = body_part.create_tween()
	tween.set_parallel(true)
	tween.tween_property(body_part, "scale", 0.1, 1.0)
	tween.tween_property(body_part, "modulate", Color.RED, 1.0)
	tween.tween_callback(func(): body_part.free())
	tween.kill()
