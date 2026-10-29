class_name skill_item_list_logic extends ItemList

func open_list(imported_resource : actor_skill_pool_resource) -> void:
	visible = true
	populate_list(imported_resource)

func populate_list(skill_pool_resource : actor_skill_pool_resource) -> void:
	var skill_pool : Array[special_skill_resource] = skill_pool_resource.skill_pool
	
	for special_skill : special_skill_resource in skill_pool:
		set_item_metadata( add_item(special_skill.skill_name, null, true), special_skill )

func close_list() -> void:
	visible = false
	clear()
