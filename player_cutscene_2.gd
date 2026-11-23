extends CharacterBody2D

func _ready() -> void:
	$AnimationPlayer.play("cutscene_cut_down")

func play_hit_sound():
	$AudioStreamPlayer2D.play()
