extends Node2D

@export var initial_scene: StringName = &""

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		SceneLoader.load_scene(initial_scene)
