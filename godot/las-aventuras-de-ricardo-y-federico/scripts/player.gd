extends CharacterBody2D

signal health_depleted

const SPEED = 100.0
var health = 100.0

@onready var player_sprite_2d: AnimatedSprite2D = $PlayerSprite2D
@onready var camera_2d: Camera2D = $Camera2D

@export_group("Controles")
@export var input_left: String = "ui_left"
@export var input_right: String = "ui_right"
@export var input_up: String = "ui_up"
@export var input_down: String = "ui_down"

@export var has_camera: bool = true

const BGM_GAME = preload("res://assets/RicYFed/sonidos/chiptune-grooving-142242.mp3")

func _ready() -> void:
	add_to_group("player")
	AudioManager.play_music(BGM_GAME, -10.0)
	
	if not has_camera:
		camera_2d.enabled = false
		

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector(input_left, input_right, input_up, input_down)
	
	if direction.x > 0:
		player_sprite_2d.flip_h = false
	elif direction.x < 0:
		player_sprite_2d.flip_h = true
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
	
	if player_sprite_2d.animation != "hurt":
		if velocity.length() > 0:
			player_sprite_2d.play("walk")
		else:
			player_sprite_2d.play("idle")
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		play_hurt()
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
func play_hurt():
	player_sprite_2d.play("hurt")
	await player_sprite_2d.animation_finished
	
	player_sprite_2d.play("walk")
