class_name game_camera extends Camera2D
var player : player_character

func pass_player(player_node: player_character) -> void:
	player = player_node
	scale = Vector2(2.0, 2.0)

func _physics_process(delta: float) -> void:
	position = player.position
