extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	if Global.coming_from_cutscene:
		player.global_position = Global.player_last_position
		Global.coming_from_cutscene = false
