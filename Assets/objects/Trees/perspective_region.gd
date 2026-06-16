class_name perspective_region extends Area2D

var surrounding_bodies : Array[Dictionary]

func _ready() -> void:
	connect_flags()

func connect_flags() -> void:
	self.body_entered.connect(_change_object_zorder)
	self.body_exited.connect(_reset_object_zorder)
	
func _change_object_zorder(object : CharacterBody2D) -> void:
		surrounding_bodies.append(
			{
			"object" : object,
			"original_z_index" : object.z_index,
			})
		
		object.z_index = 2
		
func _reset_object_zorder(object: CharacterBody2D) -> void:
	for body in surrounding_bodies:
		var body_object = body["object"]
		if body_object == object:
			object.z_index = body["original_z_index"]
