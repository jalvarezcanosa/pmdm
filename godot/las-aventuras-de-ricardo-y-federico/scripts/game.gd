extends Node2D
	
	
@onready var foreground: TileMapLayer = $TilemapLayers/Foreground


func spawn_mob():
	var max_attempts = 10
	var attempts = 0
	var spawn_pos = Vector2.ZERO
	var found_valid_pos = false
	
	while attempts < max_attempts:
		%PathFollow2D.progress_ratio = randf()
		spawn_pos = %PathFollow2D.global_position
		
		var local_pos = foreground.to_local(spawn_pos)
		var map_coords = foreground.local_to_map(local_pos)
		
		if foreground.get_cell_source_id(map_coords) != -1:
			found_valid_pos = true
			break
			
		attempts += 1
	
	if found_valid_pos:
		var new_mob = preload("res://scenes/mob.tscn").instantiate()
		new_mob.global_position = spawn_pos
		add_child(new_mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
