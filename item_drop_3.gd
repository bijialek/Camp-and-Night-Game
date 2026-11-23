extends Area2D

@onready var surat_audio: AudioStreamPlayer2D = $SuratAudio

var picked: bool = false

func _ready() -> void:
	$".".hide()
	
	if Global.is_birch_out:
		$".".show()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.add_item(self)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.remove_item(self)

func interact():
	if picked:
		return
	picked = true
	pickup()

func pickup():
	if not surat_audio.is_playing(): surat_audio.play()
	$Surat.hide()
	await get_tree().create_timer(0.3).timeout
	queue_free()
