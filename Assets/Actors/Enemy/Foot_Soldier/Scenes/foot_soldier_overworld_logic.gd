class_name foot_soldier_overworld extends enemy_character

func _ready() -> void:
	combat_counterpart = load("uid://bht10fb1cx40u").instantiate()
