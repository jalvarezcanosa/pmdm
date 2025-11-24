extends Area2D

@export var player_id: int = 2  
@export var damage_interval: float = 0.5

@onready var timer = $DamageTimer

func _ready() -> void:
	timer.wait_time = damage_interval
	timer.start()

	timer.timeout.connect(_on_damage_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_damage_timer_timeout():
	var enemies = get_overlapping_bodies()
	
	for body in enemies:
		if body.has_method("take_damage") and not body.is_in_group("player"):
			
			body.take_damage(player_id)
			
			if body.get("visual_node"):
				body.visual_node.modulate = Color.RED
				await get_tree().create_timer(0.1).timeout
				body.visual_node.modulate = Color.WHITE
