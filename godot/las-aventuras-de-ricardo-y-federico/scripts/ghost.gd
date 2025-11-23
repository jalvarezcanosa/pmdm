extends Node2D


func play_walk():
	%GhostSprite.play("walk")
	
func play_hurt():
	%GhostSprite.play("hurt")
	%GhostSprite.queue("walk")
