extends CharacterBody2D

@export var speed = 10

signal contacted_enemy(enemy: CharacterBody2D)
signal prompt_overworld_event_description(description: String)


var active: bool = true
var combat_scene = preload("res://Player Characters/Kevin/Kevin_Player_Fighting.tscn")



func _ready() -> void:
	add_to_group('Player')

func _physics_process(delta: float) -> void:	
		move_and_slide()
		if get_slide_collision_count() > 0:
			send_collision_data()
			
func _input(event: InputEvent) -> void:
		if active == true:
			var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			velocity = direction * speed
			
			if direction == Vector2.LEFT:
				%Object_Raycast_Detection.rotation_degrees = 90
			if direction == Vector2.RIGHT:
				%Object_Raycast_Detection.rotation_degrees = -90
			if direction == Vector2.UP:
				%Object_Raycast_Detection.rotation_degrees = 180
			if direction == Vector2.DOWN:
				%Object_Raycast_Detection.rotation_degrees = 0
		
		if Input.is_action_pressed("ui_accept"):
			var object = %Object_Raycast_Detection.get_collider()
			prompt_overworld_event_description.emit("You pick up a Squishy!")
			
			#print_debug(%Object_Raycast_Detection.get_collision_mask_value())
			


func initiate_combat():
	#print('This is running multiple times huh')
	active = false
	%CollisionShape2D.disabled = true
	%Overworld_Sprite.visible = false
	%Combat_Sprite.visible = true
	
func end_combat():
	active = true
	%Overworld_Sprite.visible = true
	%Combat_Sprite.visible = false
	%CollisionShape2D.disabled = false
	
func send_collision_data():
	var enemy_collided_with: Node2D = get_last_slide_collision().get_collider()
	#print_debug(enemy_collided_with)
	if enemy_collided_with.is_in_group('Enemy'):
		active = false
		contacted_enemy.emit(enemy_collided_with)
	else:
		pass
