extends Node2D

@onready var music_player = $MusicPlayer


func play_music(stream: AudioStream, volume_db: float = 0.0):
	# Si ya está sonando la misma canción, no la reiniciamos
	if music_player.stream == stream and music_player.playing:
		return
	
	music_player.stream = stream
	music_player.volume_db = volume_db
	music_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func stop_music():
	music_player.stop()
	
	
func play_sfx(stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0):
	if stream == null:
		return
		
	# 1. Creamos un reproductor temporal
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.volume_db = volume_db
	sfx_player.pitch_scale = pitch_scale
	
	# 2. Lo añadimos como hijo del AudioManager
	add_child(sfx_player)
	
	# 3. Lo reproducimos
	sfx_player.play()
	
	# 4. Conectamos su señal de finalización para que se autoborre
	# Esto es vital para no llenar la memoria de nodos basura
	sfx_player.finished.connect(sfx_player.queue_free)
