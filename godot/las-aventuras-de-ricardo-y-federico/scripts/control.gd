extends Control

var master_bus_index = AudioServer.get_bus_index("Master")

const MENU_MUSIC = preload("res://assets/RicYFed/sonidos/chiptune-grooving-142242.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	%OptionsPanel.visible = false
	
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

	if AudioManager:
		AudioManager.play_music(MENU_MUSIC)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	print("Opciones presionado")
	$VBoxContainer.visible = false 
	%OptionsPanel.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_btn_volver_pressed() -> void:
	%OptionsPanel.visible = false
	$VBoxContainer.visible = true
	

func _on_check_button_toggled(toggled_on: bool) -> void:
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
