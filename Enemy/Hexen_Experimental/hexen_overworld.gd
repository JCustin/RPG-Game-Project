extends enemy_character
@export var movement_controller : ai_movement_controller

var stat_block : hexen_stats

func _ready() -> void:
	stat_block = hexen_stats.new().duplicate()
	combat_counterpart = preload("uid://de80k8iqnbkkn").instantiate()
	


func connect_signals():
	Player_Data.combat_initiated.connect(stop_moving)
	
#var possible_behaviors : Array
func _physics_process(_delta: float) -> void:
	velocity = movement_controller.get_velocity()
	move_and_slide()
	
	
func stop_moving(_player_initiating_combat, _enemy_initiating_combat):
	movement_controller.set_process(Node.PROCESS_MODE_DISABLED)
	
func resume_movement():
	movement_controller.set_process(Node.PROCESS_MODE_INHERIT)
