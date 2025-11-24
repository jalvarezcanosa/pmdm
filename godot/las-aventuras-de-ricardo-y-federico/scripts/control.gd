extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Si quieres música de fondo, este es el lugar para iniciarla
	# $AudioStreamPlayer.play()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	print("Opciones presionado")
	%OptionsPanel.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()
