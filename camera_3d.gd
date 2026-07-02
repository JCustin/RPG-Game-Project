extends Camera3D
@export var pivot : Node3D

func _physics_process(delta: float) -> void:
	pivot.rotation_degrees.y += 0.3

#func _input(event: InputEvent) -> void:
	#if Input.is_action_pressed("ui_left"):
		#position.x -= 0.1
		#
	#if Input.is_action_pressed("ui_right"):
		#position.x += 0.1
