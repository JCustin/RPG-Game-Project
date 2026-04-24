extends Node
#var inventory_menu = preload()



func open_inventory():
	var items_in_inventory = get_children()
	for item in items_in_inventory:
		print_debug(item)
