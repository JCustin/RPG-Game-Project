class_name map_transition_stage_area extends Area2D

signal player_entered_transition_stage_area(stage_area : map_transition_stage_area)
var player_in_transition_stage : bool = false
@export var spawn_point : Node2D

func _ready() -> void:
	self.body_entered.connect(_validate_player_entered_stage)
	
func _validate_player_entered_stage(body) -> void:
	if body is player_character and player_in_transition_stage == false:
		player_entered_transition_stage_area.emit(self)
		player_in_transition_stage = true
		
	else:
		pass
