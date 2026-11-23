extends Area2D

@onready var camp_label: Label = $Label

# Variabel untuk mengecek apakah player sedang berada di dekat pohon
var is_player_near: bool = false


func _ready() -> void:
	# Hilangin dulu label nya
	camp_label.hide()
	$AnimatedSprite2D.hide()
	$AudioStreamPlayer2D.stop()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and Global.kayu_taken() :
		is_player_near = true
		camp_label.show()


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		camp_label.hide()
