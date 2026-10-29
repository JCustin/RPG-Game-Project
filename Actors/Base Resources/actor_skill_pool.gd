class_name actor_skill_pool_resource extends Resource

@export var skill_pool : Array[special_skill_resource]

func add_skill_to_pool(skill : combat_skill_resource) -> void:
	skill_pool.append(skill)
	
func return_all_skills() -> Array[special_skill_resource]:
	return skill_pool
