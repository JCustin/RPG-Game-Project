class_name actor_placer_component extends Node

func prepare_actors(player: combat_player_character, enemy: combat_enemy_character) -> void:
	player.position = Vector2(250,20)
	enemy.position = Vector2(0,0)
	enemy.scale = Vector2(1.5, 1.5)
