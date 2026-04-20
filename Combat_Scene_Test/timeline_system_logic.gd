extends Node


@export var maximum_timeline_value : int = 100

var turn_queue : Dictionary # key: node, value: speed

func assign_turn_queue():
	var players = %Player_Actors.get_children()
	var enemy = %Enemy_Actors.get_child(0)
	
	for player in players:
		turn_queue[player] = player.SPD
		
	turn_queue[enemy] = enemy.SPD
	turn_queue.sort()
	
	print_debug(turn_queue)
