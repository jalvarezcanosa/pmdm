extends Node2D
	
@export var mob_scenes: Array[PackedScene] = []
@export var max_mobs: int = 70

@onready var foreground: TileMapLayer = $TilemapLayers/Foreground


var enemy_count = 0
var score1 = 0
var score2 = 0

func _ready() -> void:
	update_score_label()
	

func spawn_mob():
	if enemy_count >= max_mobs:
		return
		
	if mob_scenes.is_empty():
		print_debug("¡Error! No has asignado escenas en la lista 'Mob Scenes'")
		return
		
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
		var random_scene = mob_scenes.pick_random()
		
		var new_mob = random_scene.instantiate()
		new_mob.global_position = spawn_pos
		add_child(new_mob)
		
		enemy_count += 1
		
		new_mob.tree_exiting.connect(_on_mob_deleted)
		
		new_mob.mob_killed.connect(_on_mob_killed)


func _on_mob_deleted():
	enemy_count -= 1
	
	
func _on_mob_killed(points_earned, killer_id):
	if killer_id == 1:
		score1 += points_earned
	elif killer_id == 2:
		score2 += points_earned
	else:
		pass
		
	update_score_label()
	
	
func update_score_label():
	if %ScoreLabel1:
		%ScoreLabel1.text = "Score: " +str(score1)
	if %ScoreLabel2:
		%ScoreLabel2.text = "Score: " +str(score2)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true


func _on_player_2_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
