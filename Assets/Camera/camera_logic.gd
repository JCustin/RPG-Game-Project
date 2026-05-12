class_name game_camera extends Camera2D
var player : player_character

func _ready() -> void:
	player = get_tree().get_first_node_in_group('Player')
	

func _physics_process(delta: float) -> void:
	position = player.position
