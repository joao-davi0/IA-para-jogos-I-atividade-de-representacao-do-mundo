extends Node2D

@export var game_time := 60.0

const AREA_SIZE := 1152
var time_left := game_time
var game_started := false
var active_areas = []

func _process(delta):
	if game_started:
		time_left -= delta

		if time_left <= 0:
			time_left = 0
			end_game()
			
	var player = get_tree().get_first_node_in_group("player")

	if player:
		var column = int(player.global_position.x / AREA_SIZE)
		var row = int(player.global_position.y / AREA_SIZE)

		var area_name = "Area_" + str(row) + "_" + str(column)

		var current_area = get_node(area_name)

		for area in active_areas:
			area.active = false

		current_area.active = true
		active_areas.push_back(current_area)

func end_game():
	game_started = false
	var hud = $HUD
	hud.show_game_over()
