extends CharacterBody2D

signal mob_killed(points, killer_id)

@export_group("Configuración Mob")
@export var visual_node: Node2D
@export var SPEED = 75.0
@export var health = 3
@export var score_value: int = 100


var players
var last_attacker_id = 0
var is_dying = false


func _ready():
	if visual_node:
		visual_node.play_walk()


func _physics_process(delta: float) -> void:
	if is_dying:
		return
		
	var players = get_tree().get_nodes_in_group("player")
	
	if players.is_empty(): return
		
	var closest_player = players[0]
	var min_dist = global_position.distance_to(closest_player.global_position)
	
	for p in players:
		var dist = global_position.distance_to(p.global_position)
		if dist < min_dist:
			closest_player = p
			min_dist = dist
		
	var direction = global_position.direction_to(closest_player.global_position)
	velocity = direction * SPEED
	
	if visual_node:
		if direction.x > 0:
			visual_node.scale.x = -1
		elif direction.x < 0:
			visual_node.scale.x = 1

	move_and_slide()

func take_damage(attacker_id = 0):
	health -= 1
	
	last_attacker_id = attacker_id
	
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
		
	mob_killed.emit(score_value, last_attacker_id)
	
	queue_free()
