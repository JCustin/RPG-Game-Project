class_name day_night_cycle extends Node

var tween : Tween
@export var light_source : DirectionalLight2D

func apply_day_lighting() -> void:
	tween = create_tween()
	tween.tween_property(light_source, "color", Color("ffbc00"), 1.0)
	tween.tween_callback(func(): tween.kill())
	
func apply_evening_lighting() -> void:
	tween = create_tween()
	tween.tween_property(light_source, "color", Color(1.224, 0.0, 1.224), 1.0)
	tween.tween_callback(func(): tween.kill())
	
func apply_night_lighting() ->  void:
	tween = create_tween()
	tween.tween_property(light_source, "color", Color(0.072, 0.0, 1.224), 1.0)
	tween.tween_callback(func(): tween.kill())
