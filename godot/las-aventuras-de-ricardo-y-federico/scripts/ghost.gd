extends Node2D


func play_walk():
	if %GhostSprite.animation != "hurt":
		%GhostSprite.play("walk")
	
func play_hurt():
	%GhostSprite.play("hurt")
	await %GhostSprite.animation_finished
	
	%GhostSprite.play("walk")
