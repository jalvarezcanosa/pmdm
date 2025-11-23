extends Node2D


func play_walk():
	if %GoblinSprite.animation != "hurt":
		%GoblinSprite.play("walk")
	
func play_hurt():
	%GoblinSprite.play("hurt")
	await %GoblinSprite.animation_finished
	
	%GoblinSprite.play("walk")
