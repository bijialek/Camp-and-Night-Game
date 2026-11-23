extends Area2D

@onready var kapak_audio: AudioStreamPlayer2D = $KapakAudio

var picked: bool = false

func _ready() -> void:
	$".".show()
	
	if Global.is_birch_out:
		$".".hide()

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
	if not kapak_audio.is_playing(): kapak_audio.play()
	$Kapak.hide()
	await get_tree().create_timer(0.3).timeout
	queue_free()
