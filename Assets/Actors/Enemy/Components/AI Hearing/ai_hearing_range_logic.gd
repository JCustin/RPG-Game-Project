class_name ai_hearing_range extends Node2D

signal sound_heard(sound_origin: Vector2)
@export var sound_receiver : Area2D

func _ready() -> void:
	sound_receiver.area_entered.connect(_receive_sound)

func _receive_sound(sound : Area2D) -> void:
	var sound_origin = sound.global_position
	sound_heard.emit(sound_origin)
	
