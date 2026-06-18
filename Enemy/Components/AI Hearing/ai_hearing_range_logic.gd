class_name ai_hearing_range extends Node2D

signal sound_heard(sound_origin: Vector2)

@export var sound_receiver : Area2D
@export var sound_receiver_shape : CollisionShape2D
@export var sound_receiver_radius : int

func _ready() -> void:
	modify_sound_receiver_radius(sound_receiver_radius)
	sound_receiver.area_entered.connect(_receive_sound)

func _receive_sound(sound : Area2D) -> void:
	var sound_origin = sound.global_position
	sound_heard.emit(sound_origin)
	
func modify_sound_receiver_radius(new_radius_value : int) -> void:
	var sound_receiver_circle : CircleShape2D = sound_receiver_shape.shape
	sound_receiver_circle.radius = sound_receiver_radius
