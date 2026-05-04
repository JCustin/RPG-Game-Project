extends CharacterBody2D

var unit_name = "Witch Hunter"
@export var movement_speed = 100

var stat_block = witchunter_stats.new()
var HP: int

signal contacted_enemy(enemy: CharacterBody2D)
signal prompt_overworld_event_description(description: String)
signal combat_started()
signal picked_up_item(object: StaticBody2D)
signal open_inventory()

var active: bool = true
var combat_scene = preload("res://Player Characters/Kevin/Kevin_Player_Fighting.tscn")

func _ready() -> void:
	add_to_group('Player')
	HP = stat_block.HP

func _physics_process(delta: float) -> void:	
		move_and_slide()
		if get_slide_collision_count() > 0:
			send_collision_data()
			
func _input(event: InputEvent) -> void:
	if active == true:
		var direction = Input.get_vector("Movement_Left", "Movement_Right", "Movement_Up", "Movement_Down")
		velocity = direction * movement_speed
		
		if Input.is_action_just_pressed("Movement_Left"):
			%Object_Raycast_Detection.rotation_degrees = 90
		if Input.is_action_just_pressed("Movement_Right"):
			%Object_Raycast_Detection.rotation_degrees = -90
		if Input.is_action_just_pressed("Movement_Up"):
			%Object_Raycast_Detection.rotation_degrees = 180
		if Input.is_action_just_pressed("Movement_Down"):
			%Object_Raycast_Detection.rotation_degrees = 0
			
		if Input.is_action_just_pressed("ui_accept"):
			if %Object_Raycast_Detection.is_colliding() == true:
				
				var object : Variant = %Object_Raycast_Detection.get_collider()
				if object.is_class("StaticBody2D"):
					pick_up_item(object)
				elif object.is_class("TileMapLayer"):
					interact_with_terrain(object)
				else:
					pass
					
		if Input.is_action_just_pressed("Inventory"):
			if get_tree().get_nodes_in_group('Inventory').size() == 0 :
				open_inventory.emit()
			else:
				for node in get_tree().get_nodes_in_group('Inventory'):
					node.free_inventory()
				

func initiate_combat():
	active = false
	%CollisionShape2D.disabled = true
	%Overworld_Sprite.visible = false
	%Combat_Sprite.visible = true
	velocity = Vector2.ZERO
	combat_started.emit()
	
func end_combat():
	print_debug(stat_block.HP)
	active = true
	%Overworld_Sprite.visible = true
	%Combat_Sprite.visible = false
	%CollisionShape2D.disabled = false
	
func send_collision_data():
	var enemy_collided_with: Node2D = get_last_slide_collision().get_collider()
	if enemy_collided_with.is_in_group('Enemy'):
		active = false
		contacted_enemy.emit(enemy_collided_with)
	else:
		pass
		
func pick_up_item(object: StaticBody2D) -> void:
	if object.collision_layer == 2: # item on the ground
		var object_name : String = object.item_name
		var item_interaction = item_base.new()
		prompt_overworld_event_description.emit("You have picked up " + object_name)
		item_interaction.player_pick_up_item(object, %Player_Inventory)
		picked_up_item.emit()
		Player_Data.inventory += [object]

func interact_with_terrain(object: TileMapLayer) -> void:
	return
