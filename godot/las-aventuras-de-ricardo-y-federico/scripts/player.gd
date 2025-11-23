extends CharacterBody2D

signal health_depleted

const SPEED = 200.0
var health = 100.0

@onready var player_sprite_2d: AnimatedSprite2D = $PlayerSprite2D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
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
