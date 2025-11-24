extends CharacterBody2D

signal mob_killed(points)

@export_group("Configuración Mob")
@export var visual_node: Node2D
@export var SPEED = 75.0
@export var health = 3
@export var score_value: int = 100


var player
var is_dying = false


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	if visual_node:
		visual_node.play_walk()

func _physics_process(delta: float) -> void:
	if is_dying or !player:
		return
		
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	if visual_node:
		if direction.x > 0:
			visual_node.scale.x = -1
		elif direction.x < 0:
			visual_node.scale.x = 1

	move_and_slide()

func take_damage():
	health -= 1
	
	if health <= 0:
		die()
	else:
		if visual_node:
			visual_node.play_hurt()
		
func die():
	is_dying = true
	velocity = Vector2.ZERO 
	
	if visual_node:
		await visual_node.play_hurt()
		
	mob_killed.emit(score_value)
	
	queue_free()
