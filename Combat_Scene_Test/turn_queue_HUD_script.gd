class_name turn_queue_HUD extends HBoxContainer

func add_thumbnail(thumbnail_image: CompressedTexture2D):
	var thumbnail = TextureRect.new()
	add_child(thumbnail)
	thumbnail.texture = thumbnail_image
	
func clear_hud() -> void:
	for child in get_children():
		child.free()
