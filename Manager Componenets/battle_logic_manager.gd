class_name battle_logic_manager extends Node

signal attack_launched
signal attack_canceled

@export var combat_menu : VBoxContainer


func initiate_attack():
	
	pass


func restore_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = false
		
func disable_menu():
	for menu_button : Button in combat_menu.get_children():
		menu_button.disabled = true
