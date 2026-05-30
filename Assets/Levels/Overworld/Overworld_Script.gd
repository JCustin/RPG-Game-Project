class_name overworld_manager extends Node2D

@export var region : map_region
@export var day_night_system : day_night_cycle


enum day_night_states {DAY, EVENING, NIGHT} 

var time_of_day : day_night_states: 
	set(new_time_of_day):
		time_of_day = new_time_of_day
		_update_lighting()

@export var actor_manager : Node2D

# lighting system
func _update_lighting() -> void:
	match time_of_day:
		
		day_night_states.DAY:
			day_night_system.apply_day_lighting()
			
		
		day_night_states.EVENING:
			day_night_system.apply_evening_lighting()
		
		day_night_states.NIGHT:
			day_night_system.apply_night_lighting()
