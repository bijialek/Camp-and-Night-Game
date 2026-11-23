extends CharacterBody2D

func _ready():
	$AnimationPlayer.play("cutscene_wake_up")

func play_sleep():
	$AnimatedSprite2D.play("sleep")

func play_wakeup():
	$AnimatedSprite2D.play("wake_up")
