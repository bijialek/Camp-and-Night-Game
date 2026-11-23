extends CharacterBody2D


@onready var sprint_on_snow_audio: AudioStreamPlayer2D = $SprintOnSnowAudio
@onready var walk_on_snow_audio: AudioStreamPlayer2D = $WalkOnSnowAudio
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio

const SPRINT := 200.0
const SPEED := 130.0
const JUMP_VELOCITY := -400.0

var items_in_range = []


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_audio.play()

	# Take item.
	if Input.is_action_just_pressed("take_item_drop"):
			var item = get_closest_item()
			if item:
				item.interact()

	# Player's direction & run
	var direction := Input.get_axis("move_left", "move_right")

	var speed = SPEED
	if Input.is_action_pressed("sprint") and velocity.x != 0:
		speed = SPRINT
		if not sprint_on_snow_audio.is_playing(): sprint_on_snow_audio.play()
		walk_on_snow_audio.stop()
	else:
		sprint_on_snow_audio.stop()

	if direction:
		velocity.x = direction * speed
		if not walk_on_snow_audio.is_playing(): walk_on_snow_audio.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		walk_on_snow_audio.stop()


	# Player's animation
	if !is_on_floor():
		$AnimatedSprite2D.play("jump")
		walk_on_snow_audio.stop()
		sprint_on_snow_audio.stop()
	elif Input.is_action_pressed("sprint") and velocity.x != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "jump"
	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()


func add_item(item):
	items_in_range.append(item)


func remove_item(item):
	items_in_range.erase(item)


func get_closest_item():
	if items_in_range.is_empty():
		return null
	return items_in_range[0] # nanti bisa dihitung jarak
