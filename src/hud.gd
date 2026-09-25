extends CanvasLayer

func _process(_delta):
	var player = get_tree().get_first_node_in_group("player")

	if player:
		$HealthLabel.text = "HP: " + str(player.health)
		
	var world = get_parent()
	$TimerLabel.text = "Tempo: " + str(snapped(world.time_left, 0.1))

func _on_start_button_pressed():
	var world = get_parent()
	world.game_started = true
	$StartScreen.hide()

func show_game_over():
	$GameOverScreen.show()


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
