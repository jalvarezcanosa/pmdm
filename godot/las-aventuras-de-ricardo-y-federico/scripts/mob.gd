extends CharacterBody2D

var player
var health = 3
var is_dying = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	%Ghost.play_walk()

func _physics_process(delta: float) -> void:
	if is_dying or !player:
		return
		
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	
	if direction.x > 0:
		%Ghost.scale.x = 1
	elif direction.x < 0:
		%Ghost.scale.x = -1

	move_and_slide()

func take_damage():
	health -= 1
	
	if health <= 0:
		queue_free()
	else:
		%Ghost.play_hurt()
		
func die():
	is_dying = true
	velocity = Vector2.ZERO 
	
	await %Ghost.play_hurt()
	
	queue_free()
