extends Area2D

@onready var interact_label: Label = $Label

# Variabel untuk mengecek apakah player sedang berada di dekat pohon
var is_player_near: bool = false

func _ready() -> void:
	# Sembunyikan tulisan saat game baru dimulai
	interact_label.hide()
	
	# JIKA di data Global pohon sudah ditebang, langsung hilangkan dari game
	if Global.is_birch_out:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = true
		interact_label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		interact_label.hide()

func _process(_delta: float) -> void:
	if is_player_near and Input.is_action_just_pressed("interact"):
		# 1. Simpan posisi player saat ini ke Global sebelum pindah scene
		# 'get_node("../player")' berasumsi player dan pohon berada di bawah parent yang sama
		var player_node = get_node(".")
		if player_node:
			Global.player_last_position = player_node.global_position
			Global.coming_from_cutscene = true
			
		# 2. Tandai bahwa pohon ini sudah ditebang
		Global.is_birch_out = true
		
		# 3. Pindah ke cutscene
		SceneLoader.load_scene("uid://c0dl7nogshapv")
