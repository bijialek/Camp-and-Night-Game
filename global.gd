extends Node

var is_birch_out = false

var player_last_position = Vector2.ZERO

var coming_from_cutscene = false

var picked: bool = false

var has_item_drop_2 = false

@onready var kayu_banyak: Sprite2D = $KayuBanyak

func kayu_taken():
	if kayu_banyak:
		interact()

func interact():
	if picked:
		return
	picked = true
	pickup()

func pickup():
	has_item_drop_2 = true
	if kayu_banyak:
		await get_tree().create_timer(0.3).timeout
		queue_free()
