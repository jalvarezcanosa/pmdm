extends Node2D

@export var mob_scenes: Array[PackedScene] = []
@export var max_mobs: int = 70

@onready var foreground: TileMapLayer = $TilemapLayers/Foreground

const BATTLE_MUSIC = preload("res://assets/RicYFed/sonidos/chiptune-grooving-142242.mp3")
const MENU_MUSIC = preload("res://assets/RicYFed/sonidos/chiptune-grooving-142242.mp3") # Asumiendo que es la misma o tienes otra

var master_bus_index = AudioServer.get_bus_index("Master")

var enemy_count = 0
var score1 = 0
var score2 = 0

func _ready() -> void:
	update_score_label()
	
	if has_node("%PauseMenu"):
		%PauseMenu.visible = false
		%OptionsPanel.visible = false 
	
	if AudioManager:
		AudioManager.play_music(BATTLE_MUSIC)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):

		if %GameOver.visible:
			return
		toggle_pause()

func toggle_pause():
	var is_paused = get_tree().paused
	
	if is_paused:
		get_tree().paused = false
		%PauseMenu.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else:
		get_tree().paused = true
		%PauseMenu.visible = true
		%OptionsPanel.visible = false 
		$PauseLayer/PauseMenu/VBoxContainer.visible = true 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 

func _on_btn_resume_pressed() -> void:
	toggle_pause() 

func _on_btn_options_pause_pressed() -> void:
	# Ocultamos los botones de Resume/Salir y mostramos el panel de opciones
	$PauseLayer/PauseMenu/VBoxContainer.visible = false
	%OptionsPanel.visible = true

func _on_button_pressed() -> void:
	get_tree().paused = false 
	if AudioManager:
		AudioManager.play_music(MENU_MUSIC) 
	get_tree().change_scene_to_file("res://scenes/control.tscn")

func _on_btn_volver_opciones_pressed() -> void:
	%OptionsPanel.visible = false
	$PauseLayer/PauseMenu/VBoxContainer.visible = true

func _on_check_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_slider_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus_index, true)
	else:
		AudioServer.set_bus_mute(master_bus_index, false)

# --- TU LÓGICA DE JUEGO ORIGINAL (SPAWN, MOBS, ETC) ---

func spawn_mob():
	if enemy_count >= max_mobs: return
	if mob_scenes.is_empty(): return
		
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
	if killer_id == 1: score1 += points_earned
	elif killer_id == 2: score2 += points_earned
	update_score_label()
	
func update_score_label():
	if %ScoreLabel1: %ScoreLabel1.text = "Score: " +str(score1)
	if %ScoreLabel2: %ScoreLabel2.text = "Score: " +str(score2)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	if AudioManager: AudioManager.stop_music()

func _on_player_2_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	if AudioManager: AudioManager.stop_music()
	
