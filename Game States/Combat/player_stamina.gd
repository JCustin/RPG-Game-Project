extends ProgressBar

func connect_to_players(list_of_players: Array) -> void:
	for player in list_of_players:
		player.stamina_changed.connect(update_stamina_bar)

func update_stamina_bar(new_value):
	value = new_value
