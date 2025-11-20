extends CharacterBody2D

var player


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	

	move_and_slide()
