extends Area2D


@export var player_id: int = 1
@export var ammunition_scene: PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	if ammunition_scene == null:
		print("¡ERROR! No has asignado un arma al Player ", player_id)
		return
		
	var new_attack = ammunition_scene.instantiate()
	
	new_attack.global_position = %ShootingPoint.global_position
	new_attack.global_rotation = %ShootingPoint.global_rotation
	
	if "shooter_id" in new_attack:
		new_attack.shooter_id = player_id
		
	%ShootingPoint.add_child(new_attack)


func _on_timer_timeout() -> void:
	shoot()
