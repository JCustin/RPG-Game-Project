class_name combat_player_turn_component extends Node

var player_choosing_target_mode : bool = false
var player_turn : bool = false
var active_player : combat_player_character
var target_list : Array

signal player_turn_ended
signal player_opened_inventory
signal player_choosing_target


func _ready() -> void:
	_connect_signals()

func start_player_turn(active_actor: combat_player_character) -> void:
	player_turn = true
	active_player = active_actor
	
func _connect_signals() -> void:
	%Attack.pressed.connect(_enable_player_choosing_target_mode)
	%Flank.pressed.connect(_flank_enemy)
	%Item.pressed.connect(_open_inventory)
	%Flee.pressed.connect(_attempt_to_flee_combat)
	
func _enable_player_choosing_target_mode() -> void:
	player_choosing_target_mode = true
	player_choosing_target.emit()

func receive_available_targets(list_of_targets: Array) -> void:
	target_list = list_of_targets

func _open_inventory() -> void:
	pass
	
func _flank_enemy() -> void:
	pass
	
func _attempt_to_flee_combat() -> void:
	pass
