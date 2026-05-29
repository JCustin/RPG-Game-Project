class_name day_night_cycle extends Node

enum day_night_states {DAY, EVENING, NIGHT}
var current_day_night_state : day_night_states:
	set(new_state):
		current_day_night_state = new_state
		print_debug(new_state)
		_change_day_night_state()

@export var light_source : DirectionalLight2D

var tween : Tween
var day_counter : int = 0
	
signal day_night_cycle_change(state)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Exit_GUI"):
		current_day_night_state = day_night_states.NIGHT
	
func _change_day_night_state() -> void:
	tween = create_tween()
	match current_day_night_state:
		
		day_night_states.DAY:
			tween.tween_property(light_source, "color", Color("ffbc00"), 1.0)
			
		day_night_states.EVENING:
			tween.tween_property(light_source, "color", Color(1.224, 0.0, 1.224), 1.0)
			
		day_night_states.NIGHT:
			tween.tween_property(light_source, "color", Color(0.072, 0.0, 1.224), 1.0)
			
	tween.kill()
	day_night_cycle_change.emit(current_day_night_state)
