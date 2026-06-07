class_name combat_thumbnail_image extends TextureRect

signal display_turn_information(thumbnail : combat_thumbnail_image)
signal hide_turn_information(thumbnail : combat_thumbnail_image)

func _init() -> void:
	self.mouse_entered.connect(
		func(): display_turn_information.emit(self)
		)
	
	self.mouse_exited.connect(
		func(): hide_turn_information.emit(self)
	)
