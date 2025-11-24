extends Area2D

var shooter_id = 0

@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("attack")

	animated_sprite.animation_finished.connect(_on_animation_finished)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		
		body.take_damage(shooter_id)
		
func _on_animation_finished():
	queue_free()
